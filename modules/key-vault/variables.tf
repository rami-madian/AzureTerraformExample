variable "location" {
  default = ""
}

variable "tenant_id" {
  default = ""
}

variable "object_ids" {
  default = []
  description = "List of object IDs for users, service principals or security groups in the Azure Active Directory tenant for the vault."
}

variable "sku_name" {
  default = ""
}

variable "resource_group_name" {
  default = ""
}

variable "name" {
  default = ""
}

variable "storage_permissions" {
  default = []
}
variable "secret_permissions" {
  default = []
}
variable "key_permissions" {
  default = []
}