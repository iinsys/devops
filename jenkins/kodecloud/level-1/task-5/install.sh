#!/bin/bash

# Check if the PACKAGE parameter is provided
if [ -z "$PACKAGE" ]; then
    echo "Error: PACKAGE parameter is missing."
    exit 1
fi

# Define the target server and SSH credentials
SERVER="172.16.238.15"
USER="natasha"

# Install the package on the storage server
sshpass -p "Bl@kW" ssh -o StrictHostKeyChecking=no "$USER@$SERVER" "sudo apt-get update && sudo apt-get install -y $PACKAGE"

# Check if the package installation was successful
if [ $? -eq 0 ]; then
    echo "Package '$PACKAGE' installed successfully on $SERVER."
else
    echo "Failed to install package '$PACKAGE' on $SERVER."
    exit 1
fi
