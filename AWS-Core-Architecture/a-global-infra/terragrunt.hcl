/*
  Create Resource-Groups resources containing:
    - Resource-Groups Group
*/

// Include the root terragrunt - inherit parent configuration (e.g. remote backend setup)
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

// Source of Terraform module: Git or Local
terraform {
  source = "${get_terragrunt_dir()}/../modules/global/resource-groups"
}

locals {
  root        = include.root.locals
  global      = yamldecode(file("${get_terragrunt_dir()}/config-vars.yml"))
  environment = "dev"

 // computed resource names
  resource_group_name = "${local.root.resource_name}-${local.environment}-main-resource-group"
}

inputs = {
  // Resource-Groups Group
  resource_group_name        = local.resource_group_name
  resource_group_description = local.global.resource_group_description
}