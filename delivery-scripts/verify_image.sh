#!/bin/bash
# PARAMETERS
#$1 application version

# image creation verification

# Start test container
sudo docker run -d -P --name test_prjexample-webapp-$1 192.168.29.100:5000/prjexample-webapp:$1


