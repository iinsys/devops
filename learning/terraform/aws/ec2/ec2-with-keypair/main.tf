terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

resource "tls_private_key" "nb-keypair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  content  = tls_private_key.nb-keypair.private_key_pem
  filename = "${path.root}/nb-key-pair.pem"
}

resource "aws_key_pair" "nb-keypair" {
  key_name   = "nb-key-pair"
  public_key = tls_private_key.nb-keypair.public_key_openssh
}

resource "aws_instance" "demo-instance" {
  ami           = var.aws_ami_image
  instance_type = var.aws_instance_type
  key_name      = aws_key_pair.nb-keypair.key_name

  tags = {
    Name = "Demo EC2 Instance"
  }
}
