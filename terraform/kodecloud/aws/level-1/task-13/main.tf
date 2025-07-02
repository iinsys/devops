# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_s3_bucket" "private_bucket" {
  bucket = "nautilus-s3-28782"

  tags = {
    Name = "nautilus-s3-28782"
  }

  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "owner_controls" {
  bucket = aws_s3_bucket.private_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "private_access" {
  bucket                  = aws_s3_bucket.private_bucket.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
