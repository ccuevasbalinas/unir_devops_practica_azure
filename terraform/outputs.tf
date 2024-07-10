output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "container_registry_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}
