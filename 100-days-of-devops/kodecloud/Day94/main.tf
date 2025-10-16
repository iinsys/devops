
# Note: provider has already been configured in kodecloud

# Create a VPC named 'datacenter-vpc' with an IPv4 CIDR block
resource "aws_vpc" "datacenter_vpc" {
  cidr_block = "10.0.0.0/16" # You can use any valid IPv4 CIDR block
  tags = {
    Name = "datacenter-vpc"
  }
}
