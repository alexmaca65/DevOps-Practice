#
#-----------------------------------------------
#
# ROOT TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform and provides extra tools for working with multiple Terraform modules, remote state and locking: https://github.com/gruntwork-io/terragrunt
#
#-----------------------------------------------
#

locals {
  root_project_path = "${dirname(find_in_parent_folders("root.hcl"))}"

  // Automatically load common variables
  common_config = read_terragrunt_config(find_in_parent_folders("common/common.hcl"))
  common_locals = local.common_config.locals
  common_inputs = local.common_config.inputs
  resource_name = "terragrunt"
}

inputs = merge(
  local.common_inputs,
  {
    resource_name = local.resource_name
  }
)

/*
  Warning!
    - Do not move provider or remote_state blocks to common.hcl as it doesn't support include context.
    - When using read_terragrunt_config(), common.hcl is only read — it doesn't pass include context. So functions like path_relative_to_include() will return "." and state paths will break.
    - generate only works if the file is included as part of the Terragrunt hierarchy (e.g., root.hcl), not just read with read_terragrunt_config().
    - read_terragrunt_config() → only loads locals and inputs, but ignores generate, remote_state, and dependency blocks.
*/

// Generate AWS provider block
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region  = "${local.common_locals.global.aws_region}"
  profile = "${local.common_locals.global.aws_profile}"
}
EOF
}

// Configure Terragrunt to automatically store tfstate and lock files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    bucket       = "aws-infra-s3-terraform-tfstate"
    key          = "terraform-tfstate/${path_relative_to_include()}/terraform.tfstate"
    use_lockfile = true //S3 native locking
    region       = "us-east-1"
  }
}
