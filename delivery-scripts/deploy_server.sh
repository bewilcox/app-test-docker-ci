#!/bin/bash
# PARAMETERS
#$1 application version
#$2 server IP

# Arguments verification
if [ $# -ne 2 ]; then
    echo "ERROR : One argument expected --> Application version (e.q 1.0.1) and Server IP"
    exit 65
fi

# Datas
REGISTRY=192.168.29.100:5000
IMAGE_NAME=prjexample/webapp
IMAGE_VERSION=$1
RESULT=0
ENDPOINT=http://$2:4243


# Status Docker remote
res=$(curl --silent $ENDPOINT/v1/_ping)
if [ "$res" == "OK" ]; then
	echo "Remote server status : OK"
else
	echo "Error - Docker not respond on the remote server"
	RESULT=1
fi

# Stop and remove container of the application
echo "Trying to stop the container on the remote server ..."
res=$(curl -X POST --silent -o /dev/null -w "%{http_code}" $ENDPOINT/containers/prjexample-webapp/stop)
if [ "$res" == "404" ]; then
	echo "Container not found. Nothing to stop"
else
  	if [ "$res" == "204" ]; then
   		echo "Container prjexample-webap stopped"
   		echo "Trying to remove the container on the remote server ..."
   		res=$(curl -X DELETE --silent -o /dev/null -w "%{http_code}" $ENDPOINT/containers/prjexample-webapp?force=1)
   		if [ "$res" == "204" ]; then
     			echo "Container removed"
		else
			RESULT=1
			echo "An error occured during the container removal"
   		fi
  	fi
fi

# Pull or update the image
if [ "$RESULT" -eq 0 ]; then
	echo "Trying to pull the image"
	res=$(curl -X POST -o /dev/null -w "%{http_code}" $ENDPOINT/images/create?fromImage=$REGISTRY/$IMAGE_NAME&tag=$IMAGE_VERSION)
        if [ "$res" == "200" ];  then
		echo "Image pulled"
	else
		echo "An Error occurent during the image pulling"
		RESULT=1
	fi
fi

# Create the container
if [ "$RESULT" -eq 0 ]; then
	echo "Trying to create the container ..."
	json=$( echo {\"Image\":\"$REGISTRY/$IMAGE_NAME:$IMAGE_VERSION\"})
	echo "DEBUG JSON = $json"
	res=$(curl -X POST -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" -d $json $ENDPOINT/containers/create?name=prjexample-webapp )
        if [ "$res" == "201" ]; then
                echo "Container created"
        else
                echo "An error occured during the container creation"
		RESULT=1
        fi

fi

# Start the container
if [ "$RESULT" -eq 0 ]; then
        echo "Trying to start the container ..."
        json="{\"PortBindings\":{\"8080/tcp\": [{\"HostPort\":\"8080\"}]}}"
	contentype="Content-Type: application/json"
	cmd=$(echo curl --silent -X POST -o /dev/null -w "%{http_code}" -H \""$contentype"\" -d "'$json'" $ENDPOINT/containers/prjexample-webapp/start)
	echo COMMANDE = $cmd
	res=$(eval $cmd)
	if [ "$res" == "204" ]; then
                echo "Container started"
        else
                echo "An error occured during the container starting phase"
                RESULT=1
        fi

fi


echo "RESULT = ***$res***"


# Process Result
if [ "$RESULT" -eq 1 ]; then
  echo "ERROR - An error occured during the deployment phase"
  exit 1
fi
