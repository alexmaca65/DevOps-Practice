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

variable "ssh_allowed_ip" {
  description = "IP allowed to SSH into infra"
  type        = string
  // delete the default to enforce user to type his IP address
  //default = "86.121.79.15/32"
  default = "0.0.0.0/0"
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
  default = "Allow HTTP, SSH traffic from Bastion Host"
}

variable "sg_bastion_host_name" {
  type    = string
  default = "terraform-sg-bastion-host"
}

variable "sg_bastion_host_description" {
  type    = string
  default = "Allow SSH traffic"
}

variable "sg_alb_name" {
  type    = string
  default = "terraform-sg-alb"
}

variable "sg_alb_description" {
  type    = string
  default = "Allow HTTP traffic into ALB"
}

variable "sg_lt_webserver_name" {
  type    = string
  default = "terraform-sg-lt-webserver"
}

variable "sg_lt_webserver_description" {
  type    = string
  default = "Allow HTTP, SSH traffic"
}

// Security Group Ingress Rules
variable "sg_ingress_bastion_host_ssh_description" {
  type    = string
  default = "Allow SSH traffic from my IP only"
}

variable "sg_ingress_bastion_host_ssh_tag_name" {
  type    = string
  default = "allow-SSH-myIP-only"
}

variable "sg_ingress_internal_webserver_ssh_description" {
  type    = string
  default = "Allow SSH only from SG Bastion Host"
}

variable "sg_ingress_internal_webserver_ssh_tag_name" {
  type    = string
  default = "allow-SSH-sg-bastion-host-only"
}

variable "sg_ingress_internal_webserver_icmp_description" {
  type    = string
  default = "Allow Ping only from SG Bastion Host"
}

variable "sg_ingress_internal_webserver_icmp_tag_name" {
  type    = string
  default = "allow-ICMP-sg-bastion-host-only"
}

variable "sg_ingress_internal_webserver_http_description" {
  type    = string
  default = "Allow HTTP traffic only from SG Bastion Host"
}

variable "sg_ingress_internal_webserver_http_tag_name" {
  type    = string
  default = "allow-HTTP-sg-bastion-host-only"
}

variable "sg_ingress_alb_http_description" {
  type    = string
  default = "Allow HTTP traffic into ALB"
}

variable "sg_ingress_alb_http_tag_name" {
  type    = string
  default = "allow-HTTP-public"
}

variable "sg_ingress_lt_http_description" {
  type    = string
  default = "Allow HTTP traffic only from ALB"
}

variable "sg_ingress_lt_http_tag_name" {
  type    = string
  default = "allow-HTTP-sg-alb-only"
}

variable "sg_ingress_lt_ssh_description" {
  type    = string
  default = "Allow SSH traffic from my IP only"
}

variable "sg_ingress_lt_ssh_tag_name" {
  type    = string
  default = "allow-SSH-myIP-only"
}

// Security Group Egress Rule
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

// Application Load Balancer
variable "alb_name" {
  type    = string
  default = "alb-terraform"
}

// ALB Listener
variable "alb_listener_tag_name" {
  type    = string
  default = "alb-listener-http-terraform"
}

// ALB Listener Rule
variable "alb_listener_rule_error_tag_name" {
  type    = string
  default = "alb-listener-rule-error-terraform"
}

// Target Group ALB
variable "target_group_alb_name" {
  type    = string
  default = "tg-webserver-terraform"
}

// Auto Scaling
variable "autoscaling_group_name" {
  type    = string
  default = "asg-webserver-terraform"
}

// Launch Template
variable "launch_template_name" {
  type    = string
  default = "lt-webserver-terraform"
}

variable "launch_template_description" {
  type    = string
  default = "Launch Template for the Public Webserver"
}

variable "launch_template_ec2_webserver_tag_name" {
  type    = string
  default = "ec2-nginx-webserver"
}