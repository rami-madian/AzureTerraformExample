output "vm" {
  value = [
    {
      admin_password  = module.first_vm.vm-admin-password,
      admin_username  = module.first_vm.vm-admin-username,
      id              = module.first_vm.vm-id,
      identity_id     = module.first_vm.vm-identity-id
    },
    {
      admin_password  = module.second_vm.vm-admin-password,
      admin_username  = module.second_vm.vm-admin-username,
      id              = module.second_vm.vm-id,
      identity_id     = module.second_vm.vm-identity-id
    },
    {
      admin_password  = module.third_vm.vm-admin-password,
      admin_username  = module.third_vm.vm-admin-username,
      id              = module.third_vm.vm-id,
      identity_id     = module.third_vm.vm-identity-id
    }
  ]
}