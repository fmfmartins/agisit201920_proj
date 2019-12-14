#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y upgrade

# install tools for managing ppa repositories
sudo apt-get -y install software-properties-common
sudo apt-get -y install unzip
sudo apt-get -y install build-essential libssl-dev libffi-dev python-pip python3-pip

# Add graph builder tool for Terraform
sudo apt-get -y install graphviz

# install ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-add-repository -y --update ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

# Install Terraform
sudo apt-get update
export VER="0.12.17"
wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
sudo unzip terraform_${VER}_linux_amd64.zip -d /usr/local/bin
rm terraform_${VER}_linux_amd64.zip

# install OpenStack SDK modules
pip install openstacksdk
sudo apt install python3-openstackclient

# Clean up cached packages
sudo apt-get clean all

# Copy special files into /home/vagrant (from inside the mgmt node)
sudo chown -R vagrant:vagrant /home/vagrant
# Preserve original Ansible configuration files
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.org
cp /etc/ansible/hosts /etc/ansible/hosts.org
