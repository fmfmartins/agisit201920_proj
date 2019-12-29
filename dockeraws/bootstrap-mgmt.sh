#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y upgrade

# install tools for managing ppa repositories
sudo apt-get -y install software-properties-common
sudo apt-get -y install unzip
sudo apt-get -y install build-essential libssl-dev libffi-dev python-pip python3-pip
sudo apt-get -y install jq

# Add graph builder tool for Terraform
sudo apt-get -y install graphviz

# install ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-add-repository -y --update ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

# Install Terraform
sudo apt-get update
TERRAFORM_VER=$(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | egrep 'terraform_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}_linux.*amd64' | sort -V | tail -1)
curl ${TERRAFORM_VER} > ./terraform.zip
sudo unzip terraform.zip -d /usr/local/bin
rm terraform.zip

# Install the Amazon AWS CLI version 1
sudo snap install aws-cli --classic

# Clean up cached packages
sudo apt-get clean all

# Copy special files into /home/vagrant (from inside the mgmt node)
sudo chown -R vagrant:vagrant /home/vagrant
# Preserve original Ansible configuration files
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.org
cp /etc/ansible/hosts /etc/ansible/hosts.org
