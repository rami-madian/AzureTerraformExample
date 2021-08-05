resource "azurerm_key_vault" "kv" {
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  tenant_id           = var.tenant_id

  enabled_for_disk_encryption = true

  dynamic "access_policy" {
    for_each = var.object_ids
    content {
      tenant_id           = var.tenant_id
      object_id           = access_policy.value

      key_permissions     = var.key_permissions
      secret_permissions  = var.secret_permissions
      storage_permissions = var.storage_permissions
    }
  }
}