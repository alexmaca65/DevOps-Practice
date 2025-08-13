# Common variables used to name and tag resources

// AWS & Teraform
variable "aws_region" {
  type    = string
}

variable "aws_profile" {
  type    = string
}

// Universal Tag
variable "managed_by" {
  type    = string
}

// VPC
variable "vpc_tag_name" {
  type    = string
  default = ""
}

// Subnet
variable "public_subnet_a_tag_name" {
  type    = string
  default = ""
}

variable "public_subnet_b_tag_name" {
  type    = string
  default = ""
}

variable "private_subnet_a_tag_name" {
  type    = string
  default = ""
}

variable "private_subnet_b_tag_name" {
  type    = string
  default = ""
}

// Route Table
variable "public_route_table_tag_name" {
  type    = string
  default = ""
}

variable "private_route_table_tag_name" {
  type    = string
  default = ""
}

// Network ACL
variable "network_acl_tag_name" {
  type    = string
  default = ""
}

// Internet Gateway
variable "internet_gateway_tag_name" {
  type    = string
  default = ""
}

// NAT Gateway
variable "nat_gateway_tag_name" {
  type    = string
  default = ""
}

// Elastic IP
variable "elastic_ip_tag_name" {
  type    = string
  default = ""
}