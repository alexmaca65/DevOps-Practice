/*
  Create Resource Groups resources containing:
    - Resource Groups Group
    - Resource Groups Resource
*/

// Terraform Configuration
terraform {
  backend "s3" {}
}

// Resource Groups Group
resource "aws_resourcegroups_group" "main_resourcegroups_group" {
  name = "test-group"
  description = "used on "

  resource_query {

  }

  tags = {
    Name      = ""
    ManagedBy = var.managed_by
  }

}

resource "aws_resourcegroups_resource" "main_resourcegroups_resource" {
  group_arn    = aws_resourcegroups_group.main_resourcegroups_group.arn
  resource_arn = ""
}