#!/bin/bash

# Install necessary utilities
sudo yum install -y wget vim nano

# Add Jenkins repository and import the GPG key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade all packages
sudo yum upgrade -y

# Install required dependencies for Jenkins
sudo yum install -y fontconfig java-17-openjdk

# Install Jenkins
sudo yum install -y jenkins

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Start and eable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Clean up
sudo yum clean all