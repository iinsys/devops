output "s3_bucket_name" {
    value = aws_s3_bucket.nb_hosting_bucket.id
    description = "Name of the S3 bucket"
}
