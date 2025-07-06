# provider "aws" {
#   region = "us-east-1" // Change as needed
# }

resource "aws_iam_user" "main" {
  name = var.KKE_user
}