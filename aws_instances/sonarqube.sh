#!/bin/bash



yum update -y
yum install -y docker 
systemctl enable docker --now


# SonarQube installation
docker run -d -p 9000:9000 --name sonarqube sonarqube

