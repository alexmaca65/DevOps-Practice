/*
  Create Networking Core infra containing:
    - VPC
    - Subnets
*/

//Terraform Configuration
terraform {
  backend "s3" {}
}

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