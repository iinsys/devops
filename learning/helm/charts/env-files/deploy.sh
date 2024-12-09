#!/bin/bash

# Load .env file
set -a
source ./sensitive/.env || { echo "Failed to load .env file"; exit 1; }
set +a

# Create namespace if it doesn't exist
# kubectl apply -f manifests/namespace.yaml

# Deploy Helm chart into the namespace
helm upgrade --install postgres-release ./postgres-chart \
  --namespace postgres-ns \
  --create-namespace \
  --set postgres.username=$POSTGRES_USER \
  --set postgres.password=$POSTGRES_PASSWORD
