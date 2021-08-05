
variable "admin_username" {
  default = "vmAdmin"
}

variable "location" {
  default = "AustraliaCentral"
}

variable "vnet_name" {
  default = "main_vnet"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_name" {
  default = "app-subnet"
}

variable "subnet_address_prefixes" {
  default = ["10.0.2.0/24"]
}

variable "vm_name" {
  default = "app-vm"
}

variable "resource_group_name" {
  default = "ApplicationRG"
}

variable "vm_sku" {
  default = "Standard_D2_v4"
}

variable "osdisk_caching" {
  default = "ReadOnly"
}

variable "osdisk_storage_account_type" {
  default = "Standard_LRS"
}

variable "keyvault_name" {
  default = "app-secure-kv"
}

variable "keyvault_sku_name" {
  default = "standard"
}

variable "vm_key_permissions" {
  default = ["Get","List"]
}

variable "vm_secret_permissions" {
  default = ["Get","List"]
}
