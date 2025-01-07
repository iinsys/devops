terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "eu-central-1"
}

resource "aws_s3_bucket" "nb_policy_bucket" {
  bucket = "nb-policy-bucket-tf"
}

##using json encode
resource "aws_iam_policy" "jsonencode" {
  name = "tf-jsonencode"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.nb_policy_bucket.arn}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.nb_policy_bucket.arn}/*"
        ]
      }
    ]
  })
}