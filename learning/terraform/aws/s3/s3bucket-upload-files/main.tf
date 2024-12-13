resource "aws_s3_bucket" "nb_bucket" {
  bucket = "nd-bucket22"

  tags = {
    Name        = "nb-bucket"
  }
}

resource "aws_s3_bucket_object" "nb_file" {
  bucket = aws_s3_bucket.nb_bucket.id
  key    = "test.txt"
  source = "./test.txt"
}