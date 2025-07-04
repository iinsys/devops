# this is the new updated code 
resource "aws_s3_bucket" "my_bucket" {
  bucket = "devops-cp-25882"
  acl    = "private"

  tags = {
    Name        = "devops-cp-25882"
  }
}

resource "aws_s3_object" "upload_devops_txt" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "devops.txt"
  source = "/tmp/devops.txt"
  acl    = "private"
}
