#!bin/bash
sudo yum update –y

yum install docker -y
systemctl enable docker --now
usermod -aG docker jenkins

curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.57.1
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

sudo yum install java-17-amazon-corretto -y

sudo yum install jenkins -y

sudo systemctl enable jenkins --now


