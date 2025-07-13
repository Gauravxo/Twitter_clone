#!/bin/bash

yum update -y
yum install -y docker 
systemctl enable docker --now

docker run -d -p 8081:8081 --name nexus sonatype/nexus3
