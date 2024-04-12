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
    key                  = "test.terraform.tfstate"
  }
}

module "test_vm" {
  source = "../"

  resource_group_name  = "test-resource-group"
  location             = "eastus"
  storage_account_name = "testmodulesa20241204"
  tags = {
    project     = "SAANVIKIT"
    environment = "test"
  }
  virtual_network_name        = "test-vnet"
  virtual_network_address     = ["192.168.1.0/24"]
  subnet_name                 = "test-snet"
  subnet_address              = ["192.168.1.0/24"]
  network_security_group_name = "test-nsg"
  network_interface_name      = "test-nic"
  public_ip_name              = "test-pip"
  virtual_machine_name        = "test-vm"
  virtual_machine_size        = "Standard_Ds1_V2"
  AdminUser                   = "azureuser"
  AdminPassword               = "Azuredevops@12345"
}