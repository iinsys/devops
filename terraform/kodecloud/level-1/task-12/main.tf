# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_s3_bucket" "public_bucket" {
  bucket = "datacenter-s3-32544"

  tags = {
    Name = "datacenter-s3-32544"
  }

  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "owner_controls" {
  bucket = aws_s3_bucket.public_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.public_bucket.id}/*"
        ]
      }
    ]
  })
}
