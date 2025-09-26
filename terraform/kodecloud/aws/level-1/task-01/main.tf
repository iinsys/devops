resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "xfusion" {
  key_name   = "xfusion-kp"
  public_key = tls_private_key.example.public_key_openssh
}

#
resource "local_file" "private_key" {
  content              = tls_private_key.example.private_key_pem
  filename             = "/home/bob/xfusion-kp.pem"
  file_permission      = "0600"
}