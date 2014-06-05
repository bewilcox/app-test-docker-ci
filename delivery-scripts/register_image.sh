#!/bin/bash
# PARAMETERS
#$1 application version

# Arguments verification
if [ $# -ne 1 ]; then
    echo "ERROR : One argument expected --> Application version (e.q 1.0.1)"
    exit 65
fi

sudo docker pull 192.168.29.100:5000/prjexample/webapp:$1