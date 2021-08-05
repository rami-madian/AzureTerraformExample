output "vm-id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "vm-identity-id" {
  value = azurerm_windows_virtual_machine.vm.identity[0].principal_id
}

output "vm-name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "vm-admin-username" {
  value = azurerm_windows_virtual_machine.vm.admin_username
}

output "vm-admin-password" {
  value = azurerm_windows_virtual_machine.vm.admin_password
  sensitive = true
}