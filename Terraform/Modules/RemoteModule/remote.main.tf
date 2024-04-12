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
    key                  = "remote.terraform.tfstate"
  }
}

module "remote-module" {
  source = "git::https://github.com/azureramakrishna/AzureDevops-March2024.git"

  rsource_group_name   = var.rg_name
  location             = var.location
  storage_account_name = var.storage_name
  tags                 = var.tags
}