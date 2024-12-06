
resource "aws_instance" "nginx_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id = aws_subnet.public_subnet.id
  user_data = file("userdata.tpl")

  tags = {
    Name = "nginx_instance"
  }
}

# Associate Elastic IP with EC2 Instance
resource "aws_eip_association" "main" {
  instance_id = aws_instance.nginx_instance.id
  allocation_id = aws_eip.elastic_ip.id
}