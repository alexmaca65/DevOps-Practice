# Set common variables for the project. This is automatically pulled in the root terragrunt.hcl configuration to forward to child modules

// Reusable and computed vars
locals {
  global = yamldecode(file("${get_terragrunt_dir()}/common.yml"))
}

inputs = {
  name           = local.global.name
  aws_region     = local.global.aws_region
  aws_profile    = local.global.aws_profile
  managed_by     = local.global.managed_by
  ssh_allowed_ip = local.global.ssh_allowed_ip
}