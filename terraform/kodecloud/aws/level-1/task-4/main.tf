# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }

#   required_version = ">= 1.3.0"
# }

# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_vpc" "xfusion" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "xfusion-vpc"
  }
}
