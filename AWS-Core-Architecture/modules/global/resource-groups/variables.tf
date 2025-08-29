# Common variables used to name and tag resources

// AWS & Teraform
variable "aws_region" {
  type    = string
}

variable "aws_profile" {
  type = string
}

// Universal Tag
variable "managed_by" {
  type    = string
}

// Resource Group
variable "resource_group_name" {
  type    = string
  default = ""
}

variable "resource_group_description" {
  type = string
  default = ""
}