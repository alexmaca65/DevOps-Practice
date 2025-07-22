# Terraform Config

// Configure Backend for State files: state.tf
terraform {
  backend "s3" {
    bucket         = "aws-infra-s3-terraform-tfstate"
    key            = "terraform-tfstate/terraform.tfstate"
    use_lockfile   = true # S3 native locking
    region         = "us-east-1"
  }
}

// Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
