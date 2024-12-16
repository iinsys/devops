output "vpc_id" {
  description = "value of vpc id"
  value       = aws_vpc.demo_vpc.id
}

output "bucket_name" {
  value = aws_s3_bucket.nb_bucket.bucket
  description = "Name of the S3 bucket"
}

output "table_name" {
  value = aws_dynamodb_table.nb_lock_table.name
  description = "Name of the DynamoDB table"
}