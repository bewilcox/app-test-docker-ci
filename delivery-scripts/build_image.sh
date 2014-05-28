#!/bin/bash
# PARAMETERS
# $1 : Application version

# Arguments verification
if [ $# -ne 1 ]; then
    echo "ERROR : One argument expected --> Application version (e.q 1.0.1)"
    exit 65
fi

# Retrieve binairies
# War suppose to be under the current rep
#wget http://192.168.29.101:8081/nexus/content/repositories/releases/org/springframework/gs-spring-boot/$1/gs-spring-boot-$1.war
mv --force ../gs-spring-boot-$1.war ../delivery-scripts/gs-spring-boot.war

# Build Docker image
docker build --tag 192.168.29.100:5000/prjexample/webapp:$1 --rm=true .
