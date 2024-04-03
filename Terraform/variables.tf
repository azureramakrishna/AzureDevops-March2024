variable "rsource_group_name" {
  type    = string
  default = "terraform-resource-group"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "storage_account_name" {
  type    = string
  default = "TerraformSa20240403"
}

variable "tags" {
  default = {
    project     = "saanvikit"
    environment = "DEV"
  }
}