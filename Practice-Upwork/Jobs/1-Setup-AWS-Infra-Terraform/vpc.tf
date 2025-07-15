# VPC and Networking

// VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name      = var.vpc_tag_name
    ManagedBy = var.managed_by
  }
}

// Public Subnets
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.1.0.0/24"

  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = var.public_subnet_a_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.1.1.0/24"

  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name      = var.public_subnet_b_tag_name
    ManagedBy = var.managed_by
  }
}

//Private Subnets
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.1.16.0/20"

  availability_zone = "us-east-1a"

  tags = {
    Name      = var.private_subnet_a_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.1.32.0/20"

  availability_zone = "us-east-1b"

  tags = {
    Name      = var.private_subnet_b_tag_name
    ManagedBy = var.managed_by
  }
}

// Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    // route to outside to igw
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }

  route {
    // route to local
    cidr_block = aws_vpc.custom_vpc.cidr_block
    gateway_id = "local"
  }
  tags = {
    Name      = var.public_route_table_tag_name
    ManagedBy = var.managed_by
  }
}

// Public Route Table Association with Public Subnets
resource "aws_route_table_association" "public_rt_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_rt_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

// Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    // route to local
    cidr_block = aws_vpc.custom_vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name      = var.private_route_table_tag_name
    ManagedBy = var.managed_by
  }
}

// Private Route Table Association with Private Subnets
resource "aws_route_table_association" "private_rt_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_rt_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table.id
}

// Network ACL
resource "aws_network_acl" "name" {
  vpc_id = aws_vpc.custom_vpc.id
  subnet_ids = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id,
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name      = var.network_acl_tag_name
    ManagedBy = var.managed_by
  }
}

// Internet Gateway
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name      = var.internet_gateway_tag_name
    ManagedBy = var.managed_by
  }
}