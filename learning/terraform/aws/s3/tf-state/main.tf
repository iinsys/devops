# Create a vpc

resource "aws_vpc" "demo_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = var.vpc_name
    }
  
}