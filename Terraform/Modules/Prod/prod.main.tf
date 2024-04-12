terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.70.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Terraform backend
terraform {
  backend "azurerm" {
    resource_group_name  = "storage-account-resource-group"
    storage_account_name = "saanvikit20240118"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

module "prod_vm" {
  source = "../"

  resource_group_name  = "prod-resource-group"
  location             = "eastus"
  storage_account_name = "prodmodulesa20241204"
  tags = {
    project     = "SAANVIKIT"
    environment = "prod"
  }
  virtual_network_name        = "prod-vnet"
  virtual_network_address     = ["192.168.0.0/24"]
  subnet_name                 = "prod-snet"
  subnet_address              = ["192.168.0.0/24"]
  network_security_group_name = "prod-nsg"
  network_interface_name      = "prod-nic"
  public_ip_name              = "prod-pip"
  virtual_machine_name        = "prod-vm"
  virtual_machine_size        = "Standard_Ds1_V2"
  AdminUser                   = "azureuser"
  AdminPassword               = "Azuredevops@12345"
}