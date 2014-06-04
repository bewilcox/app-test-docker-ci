#!/bin/bash
# PARAMETERS
#$1 application version

# image creation verification

# Start container
JOB_ID = $(sudo docker run -d 192.168.29.100:5000/prjexample/webapp:$1)
JOB_IP = $(docker inspect --format='{{.NetworkSettings.IPAddress}}' $JOB_ID)
JOB_STATUS = $(docker inspect --format='{{.State.Running}}' $JOB_ID)
JOB_EXIT_CODE = $(docker inspect --format='{{.State.ExitCode}}' $JOB_ID)

if [$JOB_EXIT_CODE = 0] && [$JOB_STATUS = "true"]; then
	while ! curl http://$JOB_IP:8080/
	do
	  echo "$(date) - still trying"
	  sleep 1
	done
	echo "$(date) - connected successfully"

	HEALTH = $(curl http://$JOB_IP:8080/health)
	if [$HEALTH = "OK"]; then
		echo "$(date) - ERROR health return not equal to OK ( = $HEALTH)"
	else
		echo "$(date) - Application started (health return equal to OK)"
		return -1
	fi
else
	echo "$(date) - Container not running correctly (Status = $JOB_STATUS, exit_code=$JOB_EXIT_CODE)"
	return -1
fi

# Remove container
sudo docker stop $JOB_ID
sudo docker rm -f $JOB_ID
