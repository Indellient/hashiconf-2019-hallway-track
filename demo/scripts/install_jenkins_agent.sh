#!/bin/bash

# Add Docker repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install Jenkins, Java, Docker
apt-get update
apt-get install unzip default-jre docker-ce -y
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war -O /tmp/jenkins.war
unzip /tmp/jenkins.war -d /tmp/jenkins

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Configure groups
sudo usermod -aG docker vagrant

apt-get install docker-ce -y

# Install and configure Habitat
export HAB_LICENSE=accept
curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
hab pkg install core/hab-studio
hab pkg install core/hab-pkg-export-docker
