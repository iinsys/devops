
# outputs.tf
output "elastic_ip" {
  description = "The Elastic IP address assigned to the EC2 instance"
  value       = aws_eip.elastic_ip.public_ip
}

output "instance_public_ip" {
  description = "value of instance public ip"
  value = aws_eip.elastic_ip.*.public_ip
}

output "instance_security_group_id" {
  description = "value of instance security group id"
  value = aws_security_group.my_security_group.id
}

output "subnet_id" {
  description = "value of subnet id"
  value = aws_subnet.public_subnet.id
}

output "internet_gateway_id" {
  description = "value of internet gateway id"
  value = aws_internet_gateway.igw.id
}

output "key_name" {
  description = "value of key name"
  value = aws_key_pair.key_pair.key_name
}

output "private_key_path" {
    description = "value of private key path"
    value = local_file.private_key.filename
}