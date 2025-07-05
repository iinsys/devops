# provider "aws" {
#   region = "us-east-1" // Change as needed
# }

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.KKE_vpc
  }
}