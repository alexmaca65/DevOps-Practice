/*
  Create Infra containing:
    - EC2 Instances
    - Security Groups
    - Security Group Ingress Rules
    - Security Group Egress Rules
*/

//Terraform Configuration
terraform {
  backend "s3" {}
}

// Locals
locals {
  security_group_ids_map = {
    sg_bastion_host_id    = aws_security_group.sg_ec2_instance_bastion_host.id,
    sg_internal_server_id = aws_security_group.sg_ec2_instance_internal_webserver.id,
    sg_alb_id             = aws_security_group.sg_alb.id,
    sg_lt_webserver_id    = aws_security_group.sg_lt_webserver.id
  }
}

// EC2 Instances
resource "aws_instance" "ec2_instance_bastion_host" {
  ami = data.aws_ami.ami_amazon_linux_2023.id
  // use t2.micro or t3.micro to be Free Eligible
  instance_type = var.ec2_instance_type
  user_data     = file("./user-data-scripts/bastion-host-ec2-user-data.sh")

  vpc_security_group_ids = [aws_security_group.sg_ec2_instance_bastion_host.id]
  subnet_id              = var.subnet_ids_map["public_subnet_a_id"]

  tags = {
    Name      = var.ec2_instance_bastion_host_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_instance" "ec2_instance_internal_webserver" {
  ami           = data.aws_ami.ami_amazon_linux_2023.id
  instance_type = var.ec2_instance_type
  user_data     = file("./user-data-scripts/internal-webserver-ec2-user-data.sh")

  vpc_security_group_ids = [aws_security_group.sg_ec2_instance_internal_webserver.id]
  subnet_id              = var.subnet_ids_map["private_subnet_a_id"]

  tags = {
    Name      = var.ec2_instance_internal_webserver_tag_name
    ManagedBy = var.managed_by
  }
}

// Security Groups
resource "aws_security_group" "sg_ec2_instance_bastion_host" {
  name        = var.sg_bastion_host_name
  description = var.sg_bastion_host_description
  vpc_id      = var.vpc_id

  tags = {
    Name      = var.sg_bastion_host_name
    ManagedBy = var.managed_by
  }
}

resource "aws_security_group" "sg_ec2_instance_internal_webserver" {
  name        = var.sg_internal_webserver_name
  description = var.sg_internal_webserver_description
  vpc_id      = var.vpc_id

  tags = {
    Name      = var.sg_internal_webserver_name
    ManagedBy = var.managed_by
  }
}

// Security Group Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_traffic_bastion_host" {
  description       = var.sg_ingress_bastion_host_ssh_description
  security_group_id = aws_security_group.sg_ec2_instance_bastion_host.id

  cidr_ipv4   = var.ssh_allowed_ip
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  tags = {
    Name = var.sg_ingress_bastion_host_ssh_tag_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_trafic_internal_webserver" {
  description       = var.sg_ingress_internal_webserver_ssh_description
  security_group_id = aws_security_group.sg_ec2_instance_internal_webserver.id

  referenced_security_group_id = aws_security_group.sg_ec2_instance_bastion_host.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  tags = {
    Name = var.sg_ingress_internal_webserver_ssh_tag_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_traffic_internal_webserver" {
  description       = var.sg_ingress_internal_webserver_icmp_description
  security_group_id = aws_security_group.sg_ec2_instance_internal_webserver.id

  referenced_security_group_id = aws_security_group.sg_ec2_instance_bastion_host.id

  ip_protocol = "icmp"
  // -1 ==> All ports
  from_port = -1
  to_port   = -1

  tags = {
    Name = var.sg_ingress_internal_webserver_icmp_tag_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_traffic_internal_webserver" {
  description       = var.sg_ingress_internal_webserver_http_description
  security_group_id = aws_security_group.sg_ec2_instance_internal_webserver.id

  referenced_security_group_id = aws_security_group.sg_ec2_instance_bastion_host.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  tags = {
    Name = var.sg_ingress_internal_webserver_http_tag_name
  }
}

// Security Group Egress Rules
resource "aws_vpc_security_group_egress_rule" "outbound_allow_all_traffic_general" {
  depends_on = [
    aws_security_group.sg_ec2_instance_bastion_host,
    aws_security_group.sg_ec2_instance_internal_webserver,
    aws_security_group.sg_alb,
    aws_security_group.sg_lt_webserver
  ]

  for_each = local.security_group_ids_map

  description       = var.sg_egress_general_description
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1 //semantically equivalent to all ports

  tags = {
    Name = var.sg_egress_general_description
  }
}