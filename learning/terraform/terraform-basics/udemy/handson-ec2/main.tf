# Generate an RSA 4096-bit private key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a local keypair with the private keypem format
resource "local_file" "private_key" {
  filename = "${path.module}/var.key_name.pem"
  content  = tls_private_key.rsa_4096.private_key_pem
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

# Resource for instance
resource "aws_instance" "nbt_node" {
  ami             = data.aws_ami.server_ami.id
  instance_type   = var.aws_instance_type
  key_name        = aws_key_pair.key_pair.key_name
  security_groups = [aws_security_group.nbt_security_group.id]
  subnet_id       = aws_subnet.nbt_public_subnet.id

  root_block_device {
    volume_size = 20
    #volume_type = "gp2"
  }

  # User data script to set up a development environment on the EC2 instance
  user_data = file("userdata.tpl")
  tags = {
    Name = "nbt_node"
  }


}