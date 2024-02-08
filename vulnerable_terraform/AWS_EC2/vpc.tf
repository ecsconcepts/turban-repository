# Internet VPC
resource "aws_vpc" "a-test" {
  cidr_block           = var.CIDR_BLOCK
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "a-test"
  }
}

# Subnets
resource "aws_subnet" "a-test-public-1" {
  vpc_id = aws_vpc.a-test.id
  # cidr_block              = "10.0.1.0/24"
  cidr_block              = cidrsubnet(var.CIDR_BLOCK, 8, 1)
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "a-test-public-1"
  }
}

resource "aws_subnet" "test-public-2" {
  vpc_id = aws_vpc.a-test.id
  # cidr_block                = "10.0.2.0/24"
  cidr_block              = cidrsubnet(var.CIDR_BLOCK, 8, 2)
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "a-test-public-2"
  }
}

resource "aws_subnet" "test-public-3" {
  vpc_id = aws_vpc.a-test.id
  # cidr_block                = "10.0.3.0/24"
  cidr_block              = cidrsubnet(var.CIDR_BLOCK, 8, 3)
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "a-test-public-3"
  }
}

resource "aws_subnet" "test-private-1" {
  vpc_id = aws_vpc.a-test.id
  # cidr_block                = "10.0.4.0/24"
  cidr_block              = cidrsubnet(var.CIDR_BLOCK, 8, 4)
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "a-test-private-1"
  }
}

resource "aws_subnet" "a-test-private-2" {
  vpc_id = aws_vpc.a-test.id
  # cidr_block                = "10.0.5.0/24"
  cidr_block              = cidrsubnet(var.CIDR_BLOCK, 8, 5)
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}b"

  tags = {
    Name = "a-test-private-2"
  }
}

resource "aws_subnet" "a-test-private-3" {
  vpc_id = aws_vpc.a-test.id
  #cidr_block                 = "10.0.6.0/24"
  cidr_block              = cidrsubnet(var.CIDR_BLOCK, 8, 6)
  map_public_ip_on_launch = "false"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "a-test-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "a-test-gw" {
  vpc_id = aws_vpc.a-test.id

  tags = {
    Name = "a-test-gw"
  }
}

# route tables
resource "aws_route_table" "a-test-public" {
  vpc_id = aws_vpc.a-test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.a-test-gw.id
  }

  tags = {
    Name = "a-test-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "a-test-public-1-a" {
  subnet_id      = aws_subnet.a-test-public-1.id
  route_table_id = aws_route_table.a-test-public.id
}

resource "aws_route_table_association" "a-test-public-2-a" {
  subnet_id      = aws_subnet.a-test-public-2.id
  route_table_id = aws_route_table.a-test-public.id
}

resource "aws_route_table_association" "a-test-public-3-a" {
  subnet_id      = aws_subnet.a-test-public-3.id
  route_table_id = aws_route_table.a-test-public.id
}

output "vpc_id" {
  value = aws_vpc.a-test.id
}
