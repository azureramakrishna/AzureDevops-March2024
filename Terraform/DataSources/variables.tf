variable "rsource_group_name" {
  type    = string
  default = "data-sources-group"
}

# variable "location" {
#   type    = string
#   default = "uksouth"
# }

variable "client_secret" {

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

variable "virtual_network_name" {
  type    = string
  default = "test-vnet"
}

# variable "virtual_network_address" {
#   type    = list(string)
#   default = ["172.16.0.0/24"]
# }

variable "subnet_name" {
  type    = string
  default = "default"
}

# variable "subnet_address" {
#   type    = list(string)
#   default = ["172.16.0.0/24"]
# }

variable "network_security_group_name" {
  type    = string
  default = "terraform-nsg"
}

variable "network_interface_name" {
  type    = string
  default = "terraform-nic"
}

variable "public_ip_name" {
  type    = string
  default = "terraform-pip"
}

variable "virtual_machine_name" {
  type    = string
  default = "terraform-vm"
}

variable "virtual_machine_size" {
  type    = string
  default = "Standard_Ds1_v2"
}

variable "AdminUser" {
  type    = string
  default = "azureuser"
}

# variable "AdminPassword" {
#   type = string
# }