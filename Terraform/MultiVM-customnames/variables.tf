variable "rsource_group_name" {
  type    = string
  default = "saanvikit-resource-group"
}

variable "location" {
  type    = string
  default = "centralindia"
}

variable "storage_account_name" {
  type    = string
  default = "saanvikitSa202404098"
}

variable "tags" {
  default = {
    project     = "saanvikit"
    environment = "DEV"
  }
}

variable "virtual_network_name" {
  type    = string
  default = "saanvikit-vnet"
}

variable "virtual_network_address" {
  type    = list(string)
  default = ["172.16.0.0/24"]
}

variable "subnet_name" {
  type    = string
  default = "saanvikit-snet"
}

variable "subnet_address" {
  type    = list(string)
  default = ["172.16.0.0/24"]
}

variable "network_security_group_name" {
  type    = string
  default = "saanvikit-nsg"
}

variable "network_interface_name" {
  type    = string
  default = "saanvikit-nic"
}

variable "public_ip_name" {
  type    = string
  default = "saanvikit-pip"
}

variable "virtual_machine_name" {
  type    = list(string)
  default = ["abhay-vm", "dheeraj-vm", "jessy-vm", "ornes-vm", "swapnil-vm"]
}

variable "virtual_machine_size" {
  type    = string
  default = "Standard_Ds1_v2"
}

variable "AdminUser" {
  type    = string
  default = "azureuser"
}

variable "AdminPassword" {
  type    = string
  default = "Azuredevops@12345"
}

variable "count_value" {
  type    = number
  default = 5
}