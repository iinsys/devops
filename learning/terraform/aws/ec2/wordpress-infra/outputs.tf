output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.wordpress.public_ip
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.mysql.endpoint
}
