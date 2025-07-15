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

// EC2
variable "ec2_ami" {
  type    = string
  default = "ami-05ffe3c48a9991133"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ec2_tag_name" {
  type    = string
  default = "first-webserver-terraform"
}

// Security Groups
variable "sg_name" {
  type    = string
  default = "first-webserver-sg-terraform"
}

variable "sg_description" {
  type    = string
  default = "Allow HTTP, SSH traffic"
}

variable "sg_tag_name" {
  type    = string
  default = "first-webserver-sg-terraform"
}

variable "sg_ingress_http_description" {
  type    = string
  default = "Allow HTTP traffic"
}

variable "sg_ingress_http_tag_name" {
  type    = string
  default = "allow-http-public"
}

variable "sg_ingress_ssh_description" {
  type    = string
  default = "Allow SSH traffic"
}

variable "sg_ingress_ssh_tag_name" {
  type    = string
  default = "allow-ssh-global"
}

// VPC
variable "vpc_tag_name" {
  type    = string
  default = "first-vpc-terraform"
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
  default = "first-network-acl-terraform"
}

// Internet Gateway
variable "internet_gateway_tag_name" {
  type    = string
  default = "first-internet-gateway-terraform"
}