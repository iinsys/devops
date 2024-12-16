
resource "aws_kms_key" "nb_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "nb_bucket" {
  bucket = "nb-bucket22"
}

## Enabling bucket versioning
resource "aws_s3_bucket_versioning" "nb_bucket_versioning" {
  bucket = aws_s3_bucket.nb_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Enable server-side encryption using the KMS key
resource "aws_s3_bucket_server_side_encryption_configuration" "nb_server_side_encryption_configuration" {
  bucket = aws_s3_bucket.nb_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.nb_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

