output "s3_bucket_name" {
    value = aws_s3_bucket.nb_hosting_bucket.id
    description = "Name of the S3 bucket"
}

output "s3_bucket_website_url" {
  description = "The URL of the S3 bucket for website hosting"
  value       = "http://${aws_s3_bucket.nb_hosting_bucket.bucket}.s3-website.${var.aws_region}.amazonaws.com/"
}

output "website_url" {
    description = "URL of the S3 website"
    value       = aws_s3_bucket_website_configuration.hosting_bucket_configuration.website_endpoint
}