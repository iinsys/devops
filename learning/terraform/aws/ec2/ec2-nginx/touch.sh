#!/bin/bash

# Create project directory
# mkdir -p terraform_project
# cd terraform_project || exit

# Create empty files
touch main.tf
touch variables.tf
touch outputs.tf
touch vpc.tf
touch elastic_ip.tf
touch provider.tf
touch security_group.tf
touch userdata.tpl
touch terraform.tfvars
touch key.tf

echo "Empty Terraform project structure created successfully!"