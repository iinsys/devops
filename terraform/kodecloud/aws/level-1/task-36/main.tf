# provider "aws" {
#   region = "us-east-1" // Change as needed
# }

resource "aws_security_group" "main" {
  name        = var.KKE_sg
  description = "Security group managed by Terraform"
}