# provider "aws" {
#   region = "us-east-1"
# }

resource "aws_vpc" "datacenter" {
  cidr_block                     = "10.0.0.0/16"                # Required IPv4 CIDR block
  assign_generated_ipv6_cidr_block = true                       # Request Amazon-provided IPv6 block
  enable_dns_support            = true
  enable_dns_hostnames          = true

  tags = {
    Name = "datacenter-vpc"
  }
}
