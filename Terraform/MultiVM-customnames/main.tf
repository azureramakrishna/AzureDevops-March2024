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
    key                  = "multivmlength.terraform.tfstate"
  }
}


# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.rsource_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "sa" {
  name                     = lower(var.storage_account_name)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# Create a subnet
resource "azurerm_subnet" "snet" {
  depends_on           = [azurerm_virtual_network.vnet, azurerm_network_security_group.nsg]
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address
}

# Create a Network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Network security group association with subnet
resource "azurerm_subnet_network_security_group_association" "nsg-snet" {
  depends_on                = [azurerm_subnet.snet, azurerm_network_security_group.nsg]
  subnet_id                 = azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a public ip
resource "azurerm_public_ip" "pip" {
  name                = "${var.public_ip_name}-${count.index}"
  count               = var.count_value
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = var.tags
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_virtual_network.vnet, azurerm_public_ip.pip]
  name                = "${var.network_interface_name}-${count.index}"
  count               = var.count_value
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  depends_on          = [azurerm_network_interface.nic]
  name                = var.virtual_machine_name[count.index]
  count               = length(var.virtual_machine_name)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.virtual_machine_size
  admin_username      = var.AdminUser
  admin_password      = var.AdminPassword
  tags                = var.tags
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  os_disk {
    name                 = "${var.virtual_machine_name[count.index]}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

# Create a datadisk
resource "azurerm_managed_disk" "datadisk" {
  name                 = "${var.virtual_machine_name[count.index]}-datadisk"
  count                = var.count_value
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

# Attach the data disk to vm
resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.datadisk[count.index].id
  virtual_machine_id = azurerm_windows_virtual_machine.vm[count.index].id
  count              = var.count_value
  lun                = "10"
  caching            = "ReadWrite"
}