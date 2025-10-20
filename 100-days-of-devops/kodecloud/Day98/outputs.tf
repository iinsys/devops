output "KKE_vpc_name" {
  description = "Name of the VPC"
  value       = aws_vpc.datacenter_priv_vpc.tags.Name
}

output "KKE_subnet_name" {
  description = "Name of the subnet"
  value       = aws_subnet.datacenter_priv_subnet.tags.Name
}

output "KKE_ec2_private" {
  description = "Name of the EC2 instance"
  value       = aws_instance.datacenter_priv_ec2.tags.Name
}
