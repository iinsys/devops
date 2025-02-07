terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
  backend "s3" {
    bucket = "nb-tf-state-management22"
    key    = "terraform/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table = "nb-lock-table"
  }
}

provider "aws" {
  region = var.aws_region
}

# create vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
#   enable_dns_hostnames = true
#   enable_dns_support   = true
}


# create subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
}


# create keypair
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


## Create ec2 instance
resource "aws_instance" "nb-instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.nb-keypair.key_name
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id 

  tags = {
    Name = "Demo Instance"
    tag2 = "value2"
  }

  depends_on = [aws_vpc.main]
}


## Create security group
resource "aws_security_group" "main" {
  name        = "nb-sg"
  description = "Allow SSH inbound traffic from VPC security group"
    vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}