variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "storage_account_name" {
  type    = string
}

variable "tags" {
}

variable "virtual_network_name" {
  type    = string
}

variable "virtual_network_address" {
  type    = list(string)
}

variable "subnet_name" {
  type    = string
}

variable "subnet_address" {
  type    = list(string)
}

variable "network_security_group_name" {
  type    = string
}

variable "network_interface_name" {
  type    = string
}

variable "public_ip_name" {
  type    = string
}

variable "virtual_machine_name" {
  type    = string
}

variable "virtual_machine_size" {
  type    = string
}

variable "AdminUser" {
  type    = string
}

variable "AdminPassword" {
  type    = string
}