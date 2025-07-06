# provider "aws" {
#   region = "us-east-1" // Change as needed
# }

resource "aws_eip" "main" {
  tags = {
    Name = var.KKE_eip
  }
}