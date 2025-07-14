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
  cidr_block = "10.0.2.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name      = var.public_subnet_a_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.3.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name      = var.public_subnet_b_tag_name
    ManagedBy = var.managed_by
  }
}

//Private Subnets
resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.48.0/20"

  tags = {
    Name      = var.private_subnet_a_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.custom_vpc.id
  cidr_block = "10.0.64.0/20"

  tags = {
    Name      = var.private_subnet_b_tag_name
    ManagedBy = var.managed_by
  }
}