# provider "aws" {
#   region = "us-east-1" // Change as needed
# }

resource "aws_iam_role" "main" {
  name = var.KKE_iamrole
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}
