data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "private_zone1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = local.zone1

  tags = {
    "Name"                                        = "private-${local.zone1}"
    "kubernetes.io/role/internal-elb"             = "1"
    "kubernetes.io/cluster/${local.eks_name}"     = "owned"
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = local.zone2

  tags = {
    "Name"                                        = "private-${local.zone2}"
    "kubernetes.io/role/internal-elb"             = "1"
    "kubernetes.io/cluster/${local.eks_name}"     = "owned"
  }
}

resource "aws_subnet" "public_zone1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = local.zone1
  map_public_ip_on_launch = true

  tags = {
    "Name"                                        = "public-${local.zone1}"
    "kubernetes.io/role/elb"                      = "1"
    "kubernetes.io/cluster/${local.eks_name}"     = "owned"
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = local.zone2
  map_public_ip_on_launch = true

  tags = {
    "Name"                                        = "public-${local.zone2}"
    "kubernetes.io/role/elb"                      = "1"
    "kubernetes.io/cluster/${local.eks_name}"     = "owned"
  }
}

resource "aws_eip" "zone1" {
  domain = "vpc"

  tags = {
    Name = "nat-gateway-${local.zone1}"
  }
}

resource "aws_eip" "zone2" {
  domain = "vpc"

  tags = {
    Name = "nat-gateway-${local.zone2}"
  }
}

resource "aws_nat_gateway" "zone1" {
  allocation_id = aws_eip.zone1.id
  subnet_id     = aws_subnet.public_zone1.id

  tags = {
    Name = "nat-gateway-${local.zone1}"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "zone2" {
  allocation_id = aws_eip.zone2.id
  subnet_id     = aws_subnet.public_zone2.id

  tags = {
    Name = "nat-gateway-${local.zone2}"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "private_zone1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.zone1.id
  }

  tags = {
    Name = "private-${local.zone1}"
  }
}

resource "aws_route_table" "private_zone2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.zone2.id
  }

  tags = {
    Name = "private-${local.zone2}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private_zone1" {
  subnet_id      = aws_subnet.private_zone1.id
  route_table_id = aws_route_table.private_zone1.id
}

resource "aws_route_table_association" "private_zone2" {
  subnet_id      = aws_subnet.private_zone2.id
  route_table_id = aws_route_table.private_zone2.id
}

resource "aws_route_table_association" "public_zone1" {
  subnet_id      = aws_subnet.public_zone1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_zone2" {
  subnet_id      = aws_subnet.public_zone2.id
  route_table_id = aws_route_table.public.id
}