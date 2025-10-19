
# Provider is configured externally in the kodecloud environment; do not declare provider here.

# Generate an RSA private key locally
resource "tls_private_key" "xfusion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an EC2 key pair using the generated public key
resource "aws_key_pair" "xfusion_kp" {
  key_name   = "xfusion-kp"
  public_key = tls_private_key.xfusion_key.public_key_openssh
}

# Lookup default VPC and its first subnet to launch instance
data "aws_vpc" "default" {
  default = true
}

# Get subnets in the default VPC
data "aws_subnets" "default_vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Use the first available subnet ID (if any)
locals {
  first_subnet_id = length(data.aws_subnets.default_vpc_subnets.ids) > 0 ? data.aws_subnets.default_vpc_subnets.ids[0] : ""
}

# Launch EC2 instance
resource "aws_instance" "xfusion_ec2" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  subnet_id              = local.first_subnet_id
  key_name               = aws_key_pair.xfusion_kp.key_name
  associate_public_ip_address = true

  tags = {
    Name = "xfusion-ec2"
  }
}

# Optionally output the instance ID and public IP
output "instance_id" {
  value = aws_instance.xfusion_ec2.id
}

output "public_ip" {
  value = aws_instance.xfusion_ec2.public_ip
}

# Save private key to local file during apply (warning: this will store private key on disk)
resource "local_file" "private_key" {
  content  = tls_private_key.xfusion_key.private_key_pem
  filename = "./xfusion-kp.pem"
  file_permission = "0600"
  depends_on = [aws_key_pair.xfusion_kp]
}
