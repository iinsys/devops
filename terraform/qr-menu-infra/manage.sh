#!/bin/bash

# Simple infrastructure management for testing

set -e

if [ ! -f "main.tf" ]; then
    echo "Error: Run this from the terraform directory"
    exit 1
fi

echo "QR Menu Infrastructure Management"
echo "1) Deploy"
echo "2) Destroy" 
echo "3) Status"

read -p "Choice (1-3): " choice

case $choice in
    1)
        echo "Deploying..."
        terraform init
        terraform apply
        ;;
    2)
        echo "Destroying..."
        terraform destroy
        ;;
    3)
        echo "Status:"
        if terraform output instance_id >/dev/null 2>&1; then
            terraform output
        else
            echo "No infrastructure deployed"
        fi
        ;;
    *)
        echo "Invalid choice"
        ;;
esac