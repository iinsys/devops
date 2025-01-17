## Terraform Modules
### Definition:

- Reusable blocks of infrastructure code that define common patterns or components.
Promote code organization, reusability, and maintainability.

### Key Points:
- Can be public or private.
- Can be nested within other modules for complex configurations.
- Can be parameterized to make them more flexible.
**Examples**
```h
#modules.tf
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name     = var.key_name
  tags = {
    Name = var.name
  }
}
```
**main.tf**
```h
module "ec2_instance" {
  source = "./modules/ec2"

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name     = "my-key-pair"
  name         = "Example EC2 Instance"
}
```
This module creates a basic EC2 instance, taking parameters for AMI, instance type, key name, and instance name.

## Terraform Vaults
### Definition:

- Securely store sensitive data (e.g., passwords, API keys) to prevent exposure in version control.
Managed using Terraform state.

### Key Points:
- Use terraform state to manage vaults.
- Can be used with any Terraform backend.
- Can be encrypted for additional security.
**Example:**
```h
#variables.tf
variable "aws_access_key_id" {
  type        = string
  sensitive = true
}

variable "aws_secret_access_key" {
  type        = string
  sensitive = true
}
```
**main.tf**
```h
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
```
### Using Terraform State to Manage Vaults:

- Initialize the state: terraform init
- Set the variables: terraform workspace new dev
- Apply the configuration: terraform apply -var-file=dev.tfvars

Enter the sensitive values when prompted.