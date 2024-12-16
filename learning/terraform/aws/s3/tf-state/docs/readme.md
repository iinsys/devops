## This is a simple demostration on how to backup Terraform files using S3 bucket

**Prerequisites**
- AWS CLI
- Terraform basics
- AWS Basics


Make sure to create your `terraform.tfvars` with the following 
```bash
vpc_cidr = "your_cidr"
vpc_name = "your_vpc_name"
aws_access_key = "your_aws_access_key"
aws_secret_key = "your_aws_secret_key"
```

**Note:**
Also make sure to delete all the objects in the bucket before destroying the infrastructure.
#### Run
```bash
alias tf=terraform
##run
tf init

tf plan

tf apply

tf init --reconfigure

terraform plan -lock=false

terraform destroy --auto-approve -lock=false



##debugging
TF_LOG=DEBUG terraform plan

```