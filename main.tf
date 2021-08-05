terraform {
  required_providers {
    azurerm = {
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# Create a resource group
resource "azurerm_resource_group" "application" {
  name     = var.resource_group_name
  location = var.location
}

# Create a VNET
resource "azurerm_virtual_network" "application_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.application.name
}

# Create a subnet
resource "azurerm_subnet" "application_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.application.name
  virtual_network_name = azurerm_virtual_network.application_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

# Random password generator for the admin password
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

module "first_vm" {
  source = "./modules/vm"

  admin_username        = var.admin_username
  admin_password        = "${random_password.password.result}-0"
  location              = var.location
  name                  = "${var.vm_name}-0"
  resource_group_name   = azurerm_resource_group.application.name
  size                  = var.vm_sku
  caching               = var.osdisk_caching
  storage_account_type  = var.osdisk_storage_account_type
  subnet_id             = azurerm_subnet.application_subnet.id
}

module "second_vm" {
  source = "./modules/vm"

  admin_username        = var.admin_username
  admin_password        = "${random_password.password.result}-1"
  location              = var.location
  name                  = "${var.vm_name}-1"
  resource_group_name   = azurerm_resource_group.application.name
  size                  = var.vm_sku
  caching               = var.osdisk_caching
  storage_account_type  = var.osdisk_storage_account_type
  subnet_id             = azurerm_subnet.application_subnet.id
}

module "third_vm" {
  source = "./modules/vm"

  admin_username        = var.admin_username
  admin_password        = "${random_password.password.result}-2"
  location              = var.location
  name                  = "${var.vm_name}-2"
  resource_group_name   = azurerm_resource_group.application.name
  size                  = var.vm_sku
  caching               = var.osdisk_caching
  storage_account_type  = var.osdisk_storage_account_type
  subnet_id             = azurerm_subnet.application_subnet.id
}

module "key_vault" {
  source = "./modules/key-vault"

  location              = var.location
  tenant_id             = data.azurerm_client_config.current.tenant_id
  sku_name              = var.keyvault_sku_name
  resource_group_name   = azurerm_resource_group.application.name
  name                  = var.keyvault_name
  object_ids            = [module.first_vm.vm-identity-id, module.second_vm.vm-identity-id, module.third_vm.vm-identity-id ]
  key_permissions       = var.vm_key_permissions
  secret_permissions    = var.vm_secret_permissions
}
