# provider "aws" {
#   region = "us-east-1"
# }

# Create key pair
resource "tls_private_key" "nautilus_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp"
  public_key = tls_private_key.nautilus_key.public_key_openssh
}

# Save private key locally (optional but useful)
resource "local_file" "private_key" {
  content  = tls_private_key.nautilus_key.private_key_pem
  filename = "${path.module}/nautilus-kp.pem"
  file_permission = "0400"
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default security group
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# Launch EC2 instance
resource "aws_instance" "nautilus_ec2" {
  ami                         = "ami-0c101f26f147fa7fd"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.nautilus_kp.key_name
  vpc_security_group_ids      = [data.aws_security_group.default.id]

  tags = {
    Name = "nautilus-ec2"
  }
}
