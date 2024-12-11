#!/bin/bash

# Load the environment variables from .env file while ignoring comments and empty lines
echo "Loading environment variables from .env file..."
set -a
source config/.env  # Ensure this file exists in the config directory
set +a

# Deploy MongoDB using Helm with credentials from the .env file
echo "Deploying MongoDB using Helm..."

helm upgrade --install mongodb ./mongodb \
  --set mongodb.username=$MONGO_INITDB_ROOT_USERNAME \
  --set mongodb.password=$MONGO_INITDB_ROOT_PASSWORD

# Check if the deployment was successful
if [ $? -eq 0 ]; then
  echo "MongoDB deployed successfully!"
else
  echo "MongoDB deployment failed."
fi
