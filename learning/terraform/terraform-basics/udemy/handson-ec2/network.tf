# Create a VPC
resource "aws_vpc" "nbt_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "nbt-vpc"
  }
}

# Create a public subnet and referencing resource
resource "aws_subnet" "nbt_public_subnet" {
  vpc_id                  = aws_vpc.nbt_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    Name = "nbt-public-subnet"
  }
}

# Create an internet gateway 
resource "aws_internet_gateway" "nbt_igw" {
  vpc_id = aws_vpc.nbt_vpc.id

  tags = {
    Name = "nbt-igw"
  }
}

# Create a route table
resource "aws_route_table" "nbt_public_rt" {
  vpc_id = aws_vpc.nbt_vpc.id

  #   route {
  #     cidr_block = "0.0.0.0/0"
  #     gateway_id = aws_internet_gateway.nbt_igw.id    
  #   }

  tags = {
    Name = "nbt-public-rt"
  }
}

# Create a route but can be created directly in the route table
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.nbt_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.nbt_igw.id
}

# Create a route table association
resource "aws_route_table_association" "nbt_public_assoc" {
  subnet_id      = aws_subnet.nbt_public_subnet.id
  route_table_id = aws_route_table.nbt_public_rt.id
}