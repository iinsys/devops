#!/bin/bash

echo "Loading environment variables from .env file..."
export $(cat config/.env | xargs)

echo "Initializing Terraform..."
terraform init

echo "Planning Terraform changes..."
terraform plan -var="key_name=$KEY_NAME" \
               -var="db_name=$DB_NAME" \
               -var="db_username=$DB_USERNAME" \
               -var="db_password=$DB_PASSWORD"

echo "Applying Terraform changes..."
terraform apply -var="key_name=$KEY_NAME" \
                -var="db_name=$DB_NAME" \
                -var="db_username=$DB_USERNAME" \
                -var="db_password=$DB_PASSWORD" -auto-approve
