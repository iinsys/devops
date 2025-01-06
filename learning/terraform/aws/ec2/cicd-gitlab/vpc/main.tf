resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "vpc-1"
  }
}


resource "aws_subnet" "pb_sn" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pb_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "pb_1"
  }
}

resource "aws_security_group" "pb_sg" {
  name        = "my sg"
  description = "SSH inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ext_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ext_ip]
  }
}
