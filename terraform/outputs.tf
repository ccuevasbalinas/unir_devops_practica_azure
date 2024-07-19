output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "container_registry_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "container_registry_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "virtual_machine_id" {
  value = azurerm_linux_virtual_machine.avm.id
}