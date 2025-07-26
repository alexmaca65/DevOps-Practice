/*
  Create AutoScaling infra containing:
    - EC2 Instances
    - Security Groups
    - Security Groups Rules
    - Application Load Balancer
    - Target Group
    - AutoScaling Group
    - Launch Template
*/

// Include the root terragrunt - inherit parent configuration (e.g. remote backend setup)
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

// Source of Terraform module: Git or Local
terraform {
  source = "${get_terragrunt_dir()}/../modules/autoscaling"
}

dependency "networking" {
  config_path = "${get_terragrunt_dir()}/../a-networking-infra"
}

locals {
  root        = include.root.locals
  global      = yamldecode(file("${get_terragrunt_dir()}/config-vars.yml"))
  environment = "dev"

  // computed resource names
  ec2_instance_internal_webserver_tag_name = "${local.root.resource_name}-${local.environment}-ec2-apache-internal-webserver"
  ec2_instance_bastion_host_tag_name       = "${local.root.resource_name}-${local.environment}-ec2-bastion-host"

  sg_internal_webserver_name = "${local.root.resource_name}-${local.environment}-sg-apache-internal-webserver"
  sg_bastion_host_name       = "${local.root.resource_name}-${local.environment}-sg-bastion-host"
  sg_alb_name                = "${local.root.resource_name}-${local.environment}-sg-alb"
  sg_lt_webserver_name       = "${local.root.resource_name}-${local.environment}-sg-lt-webserver"

  alb_name                         = "${local.root.resource_name}-${local.environment}-alb"
  alb_listener_tag_name            = "${local.root.resource_name}-${local.environment}-alb-listener-http"
  alb_listener_rule_error_tag_name = "${local.root.resource_name}-${local.environment}-alb-listener-rule-error"

  target_group_alb_name  = "${local.root.resource_name}-${local.environment}-tg-webserver"
  autoscaling_group_name = "${local.root.resource_name}-${local.environment}-asg-webserver"
  launch_template_name   = "${local.root.resource_name}-${local.environment}-lt-webserver"

  launch_template_ec2_webserver_tag_name = "${local.root.resource_name}-${local.environment}-ec2-nginx-webserver"
}

inputs = {
  // Networking Dependency Variables
  vpc_id         = dependency.networking.outputs.vpc_id
  subnet_ids_map = dependency.networking.outputs.subnet_ids_map 

  // EC2 Instances
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