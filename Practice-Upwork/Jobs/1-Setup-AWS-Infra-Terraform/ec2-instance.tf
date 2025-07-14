# EC2 Instance

resource "aws_instance" "ec2_instance" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  vpc_security_group_ids = [aws_security_group.sg_ec2_instance.id]
  subnet_id              = var.ec2_subnet_id
  //user_data = ""

  tags = {
    Name      = var.ec2_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_security_group" "sg_ec2_instance" {
  name        = var.sg_name
  description = var.sg_description
  //vpc_id      = aws_vpc.main.id

  tags = {
    Name      = var.sg_tag_name
    ManagedBy = var.managed_by
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_traffic" {
  description       = var.sg_ingress_http_description
  security_group_id = aws_security_group.sg_ec2_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80

  tags = {
    Name = var.sg_ingress_http_tag_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_traffic" {
  description       = var.sg_ingress_ssh_description
  security_group_id = aws_security_group.sg_ec2_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22

  tags = {
    Name = var.sg_ingress_ssh_tag_name
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  description       = "Allow all traffic"
  security_group_id = aws_security_group.sg_ec2_instance.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1 //semantically equivalent to all ports
}