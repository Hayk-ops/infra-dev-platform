output "resource_group_info" {
  value = {
    name     = azurerm_resource_group.dev_rg.name
    location = azurerm_resource_group.dev_rg.location
    tags     = azurerm_resource_group.dev_rg.tags
  }
}