terraform {
    required_version = ">= 1.2.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
}

provider "aws" {
    region = "eu-central-1"
}


resource "aws_vpc" "my_vpc" {
    cidr_block = "10.2.0.0/16"

    tags = {
        Name = var.vpc_name
    }
}
  

resource "aws_instance" "app_server" {
    ami           = "ami-09042b2f6d07d164a"
    instance_type = "t2.micro"
    tags = {
        Name = var.instance_name
    }
  
}

