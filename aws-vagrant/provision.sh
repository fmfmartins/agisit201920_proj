#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker
sudo usermod -aG docker ec2-user
sudo service docker start
docker info
sudo cp /vagrant/daemon.json /etc/docker/
sudo service docker restart
