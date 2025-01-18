output "instance_id"{
    description = "The ID of the instance"
    value = aws_instance.app_server.id
}

output "instance_public_ip_address"{
    description = "The public IP address of the instance"
    value = aws_instance.app_server.public_ip
}