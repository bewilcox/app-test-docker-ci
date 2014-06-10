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
IMAGE_NAME=192.168.29.100:5000/prjexample/webapp
IMAGE_VERSION=$1
RESULT=0




# Process Result
if [ "$RESULT" -eq 1 ]; then
  echo "ERROR - An error occured during the verification phase"
  exit 1
fi
