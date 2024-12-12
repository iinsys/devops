#!/bin/bash

# Update the System Packages
sudo yum update -y

# Install Required Dependencies
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Add the Docker Repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Start and Enable Docker Service
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# Verify Docker Installation
docker --version

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Test Docker Installation
sudo docker run hello-world

# Add User to Docker Group
# Replace 'steve' with the actual username if needed
sudo usermod -aG docker steve


echo "Docker installation complete. You may need to log out and back in for user group changes to take effect."