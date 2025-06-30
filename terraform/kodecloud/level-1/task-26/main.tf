# Provision EC2 instance
resource "aws_instance" "ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  subnet_id     = "subnet-ecd29e388b7f74a3e"
  vpc_security_group_ids = [
    "sg-dbc0b8b2023fa09fc"
  ]

  tags = {
    Name = "nautilus-ec2"
  }
}

# Provision Elastic IP
resource "aws_eip" "ec2_eip" {
  domain = "vpc"

  tags = {
    Name = "nautilus-ec2-eip"
  }
}


# Attach Elastic IP to EC2 instance
resource "aws_eip_association" "eip_attachment" {
  instance_id   = aws_instance.ec2.id
  allocation_id = aws_eip.ec2_eip.id
}
