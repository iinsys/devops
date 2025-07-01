resource "aws_s3_bucket" "s3_ran_bucket" {
  bucket = "devops-s3-26507"

  tags = {
    Name = "devops-s3-26507"
  }

  }
  
  resource "aws_s3_bucket_versioning" "s3_ran_bucket_versioning" {
    bucket = aws_s3_bucket.s3_ran_bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}
