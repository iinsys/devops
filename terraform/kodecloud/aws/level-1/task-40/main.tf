# provider "aws" {
#   region = "us-east-1" # Change as needed
# }

resource "aws_iam_policy" "main" {
  name        = var.KKE_iampolicy
  description = "IAM policy managed by Terraform"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "*"
    }
  ]
}
EOF
}
