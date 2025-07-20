output "virtual_network_info" {
  value = {
    name                    = azurerm_virtual_network.dev_rg_net.name
    resource_group_name     = azurerm_virtual_network.dev_rg_net.resource_group_name
    resource_group_location = azurerm_virtual_network.dev_rg_net.location
    address_space           = azurerm_virtual_network.dev_rg_net.address_space
  }
}