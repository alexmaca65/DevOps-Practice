# Terragrunt Configuration

# Inherit parent configuration (e.g. remote backend setup)
# include "root" {
#   path   = find_in_parent_folders()
#   expose = true
# }

// Source of Terraform module: Git or Local
terraform {
  source = "../modules/autoscaling-infra"
}

// Reusable and computed vars
locals {
  global        = yamldecode(file("${get_terragrunt_dir()}/config/${local.environment}.yml"))
  resource_name = "terragrunt"
  environment   = "dev"

  // computed resource names
  ec2_instance_internal_webserver_tag_name = "${local.resource_name}-${local.environment}-ec2-apache-internal-webserver"
  ec2_instance_bastion_host_tag_name       = "${local.resource_name}-${local.environment}-ec2-bastion-host"

  sg_internal_webserver_name = "${local.resource_name}-${local.environment}-sg-apache-internal-webserver"
  sg_bastion_host_name       = "${local.resource_name}-${local.environment}-sg-bastion-host"
  sg_alb_name                = "${local.resource_name}-${local.environment}-sg-alb"
  sg_lt_webserver_name       = "${local.resource_name}-${local.environment}-sg_lt_webserver"

  vpc_tag_name = "${local.resource_name}-${local.environment}-vpc"

  public_subnet_a_tag_name  = "${local.resource_name}-${local.environment}-public-subnet-a"
  public_subnet_b_tag_name  = "${local.resource_name}-${local.environment}-public-subnet-b"
  private_subnet_a_tag_name = "${local.resource_name}-${local.environment}-private-subnet-a"
  private_subnet_b_tag_name = "${local.resource_name}-${local.environment}-private-subnet-b"

  public_route_table_tag_name  = "${local.resource_name}-${local.environment}-public-route-table"
  private_route_table_tag_name = "${local.resource_name}-${local.environment}-private-route-table"

  network_acl_tag_name      = "${local.resource_name}-${local.environment}-network-acl"
  internet_gateway_tag_name = "${local.resource_name}-${local.environment}-internet-gateway"
  nat_gateway_tag_name      = "${local.resource_name}-${local.environment}-nat-gateway"
  elastic_ip_tag_name       = "${local.resource_name}-${local.environment}-eip-nat-gateway"

  alb_name                         = "${local.resource_name}-${local.environment}-alb"
  alb_listener_tag_name            = "${local.resource_name}-${local.environment}-alb-listener-http"
  alb_listener_rule_error_tag_name = "${local.resource_name}-${local.environment}-alb-listener-rule-error"

  target_group_alb_name  = "${local.resource_name}-${local.environment}-tg-webserver"
  autoscaling_group_name = "${local.resource_name}-${local.environment}-asg-webserver"
  launch_template_name   = "${local.resource_name}-${local.environment}-lt-webserver"

  launch_template_ec2_webserver_tag_name = "${local.resource_name}-${local.environment}-ec2-nginx-webserver"
}

inputs = {
  // AWS & Terraform
  aws_region  = local.global.aws_region
  aws_profile = local.global.aws_profile
  managed_by  = local.global.managed_by

  // EC2 Instances
  ssh_allowed_ip    = local.global.ssh_allowed_ip
  ec2_instance_type = local.global.ec2_instance_type

  ec2_instance_internal_webserver_tag_name = local.ec2_instance_internal_webserver_tag_name
  ec2_instance_bastion_host_tag_name       = local.ec2_instance_bastion_host_tag_name

  // Security Groups
  sg_internal_webserver_name        = local.sg_internal_webserver_name
  sg_internal_webserver_description = local.global.sg_internal_webserver_description

  sg_bastion_host_name        = local.sg_bastion_host_name
  sg_bastion_host_description = local.global.sg_bastion_host_description

  sg_alb_name          = local.sg_alb_name
  sg_alb_description   = local.global.sg_alb_description

  sg_lt_webserver_name        = local.sg_lt_webserver_name
  sg_lt_webserver_description = local.global.sg_lt_webserver_description

  // Security Group Rules
  sg_ingress_bastion_host_ssh_tag_name    = local.global.sg_ingress_bastion_host_ssh_tag_name
  sg_ingress_bastion_host_ssh_description = local.global.sg_ingress_bastion_host_ssh_description

  sg_ingress_internal_webserver_ssh_tag_name     = local.global.sg_ingress_internal_webserver_ssh_tag_name
  sg_ingress_internal_webserver_ssh_description  = local.global.sg_ingress_internal_webserver_ssh_description

  sg_ingress_internal_webserver_icmp_tag_name    = local.global.sg_ingress_internal_webserver_icmp_tag_name
  sg_ingress_internal_webserver_icmp_description = local.global.sg_ingress_internal_webserver_icmp_description

  sg_ingress_internal_webserver_http_tag_name    = local.global.sg_ingress_internal_webserver_http_tag_name
  sg_ingress_internal_webserver_http_description = local.global.sg_ingress_internal_webserver_http_description

  sg_ingress_alb_http_tag_name    = local.global.sg_ingress_alb_http_tag_name
  sg_ingress_alb_http_description = local.global.sg_ingress_alb_http_description

  sg_ingress_lt_http_tag_name     = local.global.sg_ingress_lt_http_tag_name
  sg_ingress_lt_http_description  = local.global.sg_ingress_lt_http_description

  sg_ingress_lt_ssh_tag_name      = local.global.sg_ingress_lt_ssh_tag_name
  sg_ingress_lt_ssh_description   = local.global.sg_ingress_lt_ssh_description

  // Security Group Egress Rule
  sg_egress_general_description   = local.global.sg_egress_general_description

  // VPC
  vpc_tag_name = local.vpc_tag_name

  // Subnets
  public_subnet_a_tag_name  = local.public_subnet_a_tag_name
  public_subnet_b_tag_name  = local.public_subnet_b_tag_name
  private_subnet_a_tag_name = local.private_subnet_a_tag_name
  private_subnet_b_tag_name = local.private_subnet_b_tag_name

  // Route Tables
  public_route_table_tag_name  = local.public_route_table_tag_name
  private_route_table_tag_name = local.private_route_table_tag_name

  // Network / Gateways
  network_acl_tag_name      = local.network_acl_tag_name
  internet_gateway_tag_name = local.internet_gateway_tag_name
  nat_gateway_tag_name      = local.nat_gateway_tag_name
  elastic_ip_tag_name       = local.elastic_ip_tag_name

  // ALB
  alb_name                         = local.alb_name
  alb_listener_tag_name            = local.alb_listener_tag_name
  alb_listener_rule_error_tag_name = local.alb_listener_rule_error_tag_name

  // Auto Scaling
  target_group_alb_name  = local.target_group_alb_name
  autoscaling_group_name = local.autoscaling_group_name
  launch_template_name   = local.launch_template_name

  launch_template_ec2_webserver_tag_name = local.launch_template_ec2_webserver_tag_name
  launch_template_description            = local.global.launch_template_description
}