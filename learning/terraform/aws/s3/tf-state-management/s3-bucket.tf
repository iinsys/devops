## Create s3 bucket
resource "aws_s3_bucket" "nb-tf-state-management" {
  bucket = var.aws_s3_bucket_name
  tags = {
    Name = "nb-tf-state-management"
  }
}

resource "aws_s3_bucket_versioning" "nb_bucket_versioning" {
  bucket = aws_s3_bucket.nb-tf-state-management.id
  versioning_configuration {
    status = "Enabled"
  }
}

