```bash
# ==============================
# Terraform Workflow for EC2 with S3 State Storage and DynamoDB Locking
# ==============================

# 1️⃣ Create an S3 bucket for Terraform state storage
aws s3api create-bucket --bucket nb-tf-state-management --region eu-central-1 --create-bucket-configuration LocationConstraint=eu-central-1
## when you want to destroy the infrastructure do this first if you deleted the s3 bucket manually 
aws s3 mb s3://nb-tf-state-management22

# 2️⃣ Enable versioning on the S3 bucket (optional but recommended)
aws s3api put-bucket-versioning --bucket  nb-tf-state-management --versioning-configuration Status=Enabled

# 3️⃣ Create a DynamoDB table for Terraform state locking
aws dynamodb create-table \
  --table-name nb-lock-table \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=20,WriteCapacityUnits=20 \
  --region eu-central-1

# 4️⃣ Verify that the table has been created
aws dynamodb describe-table --table-name nb-lock-table --region eu-central-1

# 5️⃣ Initialize Terraform with backend configuration for S3 and DynamoDB
terraform init -migrate-state

# 6️⃣ Validate the Terraform configuration
terraform validate

# 7️⃣ Import the DynamoDB table into Terraform (if manually created)
terraform import aws_dynamodb_table.dynamodb-terraform-lock nb-lock-table

# 8️⃣ Run Terraform Plan to check the setup
terraform plan

# 9️⃣ Apply Terraform configuration to create the EC2 instance and configure state storage
terraform apply -auto-approve

# 🔟 Verify that the EC2 instance is running
aws ec2 describe-instances --region eu-central-1

# 1️⃣1️⃣ (Optional) Destroy all Terraform-managed resources
terraform destroy -auto-approve
```