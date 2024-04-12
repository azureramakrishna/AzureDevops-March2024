variable "rg_name" {
  type    = string
  default = "remote-resource-group"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "storage_name" {
  type    = string
  default = "remotemodulesa20241204"
}

variable "tags" {
  default = {
    project     = "SAANVIK IT"
    environment = "Remote"
  }
}