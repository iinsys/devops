output "key_name" {
    value = aws_key_pair.key_pair.key_name
    description = "Name of the key pair"
}

output "private_key" {
    value     = file(aws_key_pair.key_pair.private_key_path)
    sensitive = true
    description = "Path to the private key file"
}

output "public_ip" {
    value = aws_instance.nbt_node.public_ip
    description = "Public IP address of the EC2 instance"
}

output "instance_id" {
    value = aws_instance.nbt_node.id
    description = "ID of the EC2 instance"
}

output "aws_ami_id" {
    value = aws_instance.nbt_node.ami
    description = "AMI ID of the EC2 instance"
}

output "aws_instance_type" {
    value = aws_instance.nbt_node.instance_type
    description = "Instance type of the EC2 instance"
}