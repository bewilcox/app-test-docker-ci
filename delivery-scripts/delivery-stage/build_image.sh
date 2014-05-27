#!/bin/bash
# PARAMETERS
# $1 : Application version

# Arguments verification
if [ $# -neq 1 ]; then
    echo "One argument expected : Application version"
    exit 65 #BADARGS
fi

# Retrieve binairies
wget http://192.168.29.101:8081/nexus/content/repositories/releases/org/springframework/gs-spring-boot/$1/gs-spring-boot-$1.war
mv --force gs-spring-boot-$1.war ../image gs-spring-boot.war

# Build Docker image
sudo docker build --tag 192.168.29.100:5000/prjexample/webapp:$1 ../image
