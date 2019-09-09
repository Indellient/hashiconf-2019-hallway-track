#!/bin/bash

apt-get update
apt-get install unzip docker default-jre -y
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war -O /tmp/jenkins.war
unzip /tmp/jenkins.war -d /tmp/jenkins

curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | sudo bash
