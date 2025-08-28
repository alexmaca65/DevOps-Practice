/*
  Create Resource-Groups resources containing:
    - Resource-Groups Group
*/

// Terraform Configuration
terraform {
  backend "s3" {}
}

// Resource Groups Group
resource "aws_resourcegroups_group" "main_resourcegroups_group" {
  name        = var.resource_group_name
  description = var.resource_group_description

  resource_query {
    type = "TAG_FILTERS_1_0"

    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"]
      TagFilters = [
        {
          Key = "ManagedBy",
          Values = [var.managed_by]
        }
      ]
    })
  }

  tags = {
    Name      = var.resource_group_name
    ManagedBy = var.managed_by
  }
}