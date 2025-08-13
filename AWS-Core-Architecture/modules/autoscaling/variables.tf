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

// Networking Dependency Variables
variable "subnet_ids_map" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

// EC2 instance
variable "ssh_allowed_ip" {
  description = "IP allowed to SSH into infra"
  type        = string
  // delete the default to enforce user to type his IP address
}

variable "ec2_instance_type" {
  type    = string
}

variable "ec2_instance_internal_webserver_tag_name" {
  type    = string
  default = ""
}

variable "ec2_instance_bastion_host_tag_name" {
  type    = string
  default = ""
}

// Security Groups
variable "sg_internal_webserver_name" {
  type    = string
}

variable "sg_internal_webserver_description" {
  type    = string
  default = ""
}

variable "sg_bastion_host_name" {
  type    = string
}

variable "sg_bastion_host_description" {
  type    = string
  default = ""
}

variable "sg_alb_name" {
  type    = string
}

variable "sg_alb_description" {
  type    = string
  default = ""
}

variable "sg_lt_webserver_name" {
  type    = string
}

variable "sg_lt_webserver_description" {
  type    = string
  default = ""
}

// Security Group Ingress Rules
variable "sg_ingress_bastion_host_ssh_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_bastion_host_ssh_description" {
  type    = string
  default = ""
}

variable "sg_ingress_internal_webserver_ssh_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_internal_webserver_ssh_description" {
  type    = string
  default = ""
}

variable "sg_ingress_internal_webserver_icmp_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_internal_webserver_icmp_description" {
  type    = string
  default = ""
}

variable "sg_ingress_internal_webserver_http_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_internal_webserver_http_description" {
  type    = string
  default = ""
}

variable "sg_ingress_alb_http_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_alb_http_description" {
  type    = string
  default = ""
}

variable "sg_ingress_lt_http_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_lt_http_description" {
  type    = string
  default = ""
}

variable "sg_ingress_lt_ssh_tag_name" {
  type    = string
  default = ""
}

variable "sg_ingress_lt_ssh_description" {
  type    = string
  default = ""
}

// Security Group Egress Rule
variable "sg_egress_general_description" {
  type    = string
  default = ""
}

// Application Load Balancer
variable "alb_name" {
  type    = string
}

// ALB Listener
variable "alb_listener_tag_name" {
  type    = string
  default = ""
}

// ALB Listener Rule
variable "alb_listener_rule_error_tag_name" {
  type    = string
}

// Target Group ALB
variable "target_group_alb_name" {
  type    = string
}

// Auto Scaling
variable "autoscaling_group_name" {
  type    = string
}

// Launch Template
variable "launch_template_name" {
  type    = string
}

variable "launch_template_description" {
  type    = string
  default = ""
}

variable "launch_template_ec2_webserver_tag_name" {
  type    = string
  default = ""
}