#!/bin/bash
# PARAMETERS
#$1 application version

# Arguments verification
if [ $# -ne 1 ]; then
    echo "ERROR : One argument expected --> Application version (e.q 1.0.1)"
    exit 65
fi

RESULT=1

# image creation verification

# Start container
JOB_ID=$(sudo docker run -d 192.168.29.100:5000/prjexample/webapp:$1)
echo "JOB Started :  JOB_ID = $JOB_ID"
JOB_IP=$(sudo docker inspect --format='{{.NetworkSettings.IPAddress}}' $JOB_ID)
echo "JOB IP :  JOB_IP = $JOB_IP"
JOB_STATUS=$(sudo docker inspect --format='{{.State.Running}}' $JOB_ID)
JOB_EXIT_CODE=$(sudo docker inspect --format='{{.State.ExitCode}}' $JOB_ID)

if [ "$JOB_EXIT_CODE" == "0" ] && [ "$JOB_STATUS" == "true" ]; then
        while ! curl http://$JOB_IP:8080/
        do
          echo "Trying to connect to host  : http://$JOB_IP:8080/ ..."
          sleep 1
        done
        echo "connected successfully"

        HEALTH=$(curl http://$JOB_IP:8080/health)
        if [ "$HEALTH" != "ok" ]; then
                echo "ERROR health return not equal to OK ( = $HEALTH)"
                RESULT=0
        else
                echo "Application started (health return equal to OK)"
                RESULT=0
        fi
else
        echo "$(date) - Container not running correctly (Status = $JOB_STATUS, exit_code=$JOB_EXIT_CODE)"
        RESULT=0
fi

# Remove container
sudo docker stop $JOB_ID
sudo docker rm -f $JOB_ID

if [ "$RESULT" -eq 1 ]; then
  exit 1
fi