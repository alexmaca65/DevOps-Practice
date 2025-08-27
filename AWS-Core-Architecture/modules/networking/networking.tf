/*
  Create Networking infra containing:
    - Route Tables
    - Network ACL
    - Internet Gateway
    - NAT Gateway
    - Elastic IP
*/

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
    // route to nat gw
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.custom_ngw.id
  }

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
resource "aws_network_acl" "main_network_acl" {
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

// NAT Gateway
resource "aws_nat_gateway" "custom_ngw" {
  depends_on = [
    aws_internet_gateway.custom_igw,
    aws_eip.custom_eip
  ]

  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet_a.id
  allocation_id     = aws_eip.custom_eip.id

  tags = {
    Name      = var.nat_gateway_tag_name
    ManagedBy = var.managed_by
  }
}

// Elastic IP
resource "aws_eip" "custom_eip" {
  network_border_group = var.aws_region

  tags = {
    Name      = var.elastic_ip_tag_name
    ManagedBy = var.managed_by
  }
}