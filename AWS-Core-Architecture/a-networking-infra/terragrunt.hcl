/*
  Create Networking infra containing:
    - VPC
    - Subnets
    - Route Tables
    - Network ACL
    - Internet Gateway
    - NAT Gateway
    - Elastic IP
*/

// Include the root terragrunt - inherit parent configuration (e.g. remote backend setup)
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

// Source of Terraform module: Git or Local
terraform {
  source = "${get_terragrunt_dir()}/../modules/networking"
}

locals {
  root        = include.root.locals
  environment = "dev"

  // computed resource names
  vpc_tag_name = "${local.root.resource_name}-${local.environment}-vpc"

  public_subnet_a_tag_name  = "${local.root.resource_name}-${local.environment}-public-subnet-a"
  public_subnet_b_tag_name  = "${local.root.resource_name}-${local.environment}-public-subnet-b"
  private_subnet_a_tag_name = "${local.root.resource_name}-${local.environment}-private-subnet-a"
  private_subnet_b_tag_name = "${local.root.resource_name}-${local.environment}-private-subnet-b"

  public_route_table_tag_name  = "${local.root.resource_name}-${local.environment}-public-route-table"
  private_route_table_tag_name = "${local.root.resource_name}-${local.environment}-private-route-table"

  network_acl_tag_name      = "${local.root.resource_name}-${local.environment}-network-acl"
  internet_gateway_tag_name = "${local.root.resource_name}-${local.environment}-internet-gateway"
  nat_gateway_tag_name      = "${local.root.resource_name}-${local.environment}-nat-gateway"
  elastic_ip_tag_name       = "${local.root.resource_name}-${local.environment}-eip-nat-gateway"
}

inputs = {
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
}