#!/bin/bash

# Load .env file
set -a
source ../.env
set +a

# Deploy Helm chart, passing secrets as arguments
helm upgrade --install postgres-release ./postgres-chart \
  --set postgres.username=$POSTGRES_USER \
  --set postgres.password=$POSTGRES_PASSWORD
