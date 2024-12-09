# Generate an RSA 4096-bit private key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "${path.module}/var.key_name.pem"
  content  = tls_private_key.rsa_4096.private_key_pem
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name                           
  public_key = tls_private_key.rsa_4096.public_key_openssh  
}