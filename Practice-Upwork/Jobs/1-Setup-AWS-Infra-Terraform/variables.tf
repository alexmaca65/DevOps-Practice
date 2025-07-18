# Common vars used to name and tag resources

// AWS & Teraform
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "managed_by" {
  type    = string
  default = "Terraform"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "bastion_host_allowed_ip" {
  description = "IP allowed to SSH into the Bastion Host"
  type        = string
  // delete the default to enforce user to type his IP address
  default = "86.121.79.15/32"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_instance_internal_webserver_tag_name" {
  type    = string
  default = "ec2-apache-internal-webserver-terraform"
}

variable "ec2_instance_bastion_host_tag_name" {
  type    = string
  default = "ec2-bastion-host-terraform"
}

// Security Groups
variable "sg_internal_webserver_name" {
  type    = string
  default = "terraform-sg-apache-internal-webserver"
}

variable "sg_internal_webserver_description" {
  type    = string
  default = "Allow HTTP, SSH traffic"
}

variable "sg_internal_webserver_tag_name" {
  type    = string
  default = "terraform-sg-apache-internal-webserver"
}

variable "sg_bastion_host_name" {
  type    = string
  default = "terraform-sg-bastion-host"
}

variable "sg_bastion_host_description" {
  type    = string
  default = "Allow HTTP, SSH traffic"
}

variable "sg_bastion_host_tag_name" {
  type    = string
  default = "terraform-sg-bastion-host"
}

// Security Group Ingress Rules
variable "sg_ingress_bastion_host_ssh_description" {
  type    = string
  default = "Allow SSH traffic from my IP only"
}

variable "sg_ingress_bastion_host_ssh_tag_name" {
  type    = string
  default = "allow-ssh-myIP-only"
}

variable "sg_ingress_internal_webserver_ssh_description" {
  type    = string
  default = "Allow SSH only from SG Internal Webserver"
}

variable "sg_ingress_internal_webserver_ssh_tag_name" {
  type    = string
  default = "allow-ssh-sg-internal-webserver-only"
}

variable "sg_ingress_internal_webserver_icmp_description" {
  type    = string
  default = "Allow Ping only from SG Internal Webserver"
}

variable "sg_ingress_internal_webserver_icmp_tag_name" {
  type    = string
  default = "allow icmp-sg-internal-webserver-only"
}

variable "sg_ingress_internal_webserver_http_description" {
  type    = string
  default = "Allow HTTP traffic only from SG Internal Webserver"
}

variable "sg_ingress_internal_webserver_http_tag_name" {
  type    = string
  default = "allow-http-public"
}

// Security Group Egress Rules
variable "sg_egress_general_description" {
  type    = string
  default = "Allow all traffic"
}

// VPC
variable "vpc_tag_name" {
  type    = string
  default = "vpc-terraform"
}

// Subnet
variable "public_subnet_a_tag_name" {
  type    = string
  default = "terraform-public-subnet-a"
}

variable "public_subnet_b_tag_name" {
  type    = string
  default = "terraform-public-subnet-b"
}

variable "private_subnet_a_tag_name" {
  type    = string
  default = "terraform-private-subnet-a"
}

variable "private_subnet_b_tag_name" {
  type    = string
  default = "terraform-private-subnet-b"
}

// Route Table
variable "public_route_table_tag_name" {
  type    = string
  default = "terraform-public-route-table"
}

variable "private_route_table_tag_name" {
  type    = string
  default = "terraform-private-route-table"
}

// Network ACL
variable "network_acl_tag_name" {
  type    = string
  default = "network-acl-terraform"
}

// Internet Gateway
variable "internet_gateway_tag_name" {
  type    = string
  default = "internet-gateway-terraform"
}

// NAT Gateway
variable "nat_gateway_tag_name" {
  type    = string
  default = "nat-gateway-terraform"
}

// Elastic IP
variable "elastic_ip_tag_name" {
  type    = string
  default = "eip-nat-gateway-terraform"
}