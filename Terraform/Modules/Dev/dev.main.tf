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
    key                  = "dev.terraform.tfstate"
  }
}

module "dev_vm" {
  source = "../"

  resource_group_name  = "dev-resource-group"
  location             = "eastus"
  storage_account_name = "devmodulesa20241204"
  tags = {
    project     = "SAANVIKIT"
    environment = "DEV"
  }
  virtual_network_name        = "dev-vnet"
  virtual_network_address     = ["192.168.0.0/24"]
  subnet_name                 = "dev-snet"
  subnet_address              = ["192.168.0.0/24"]
  network_security_group_name = "dev-nsg"
  network_interface_name      = "dev-nic"
  public_ip_name              = "dev-pip"
  virtual_machine_name        = "dev-vm"
  virtual_machine_size        = "Standard_Ds1_V2"
  AdminUser                   = "azureuser"
  AdminPassword               = "AzureDevops@12345"
}