output "network_interface_info" {
  value = {
    name = azurerm_network_interface.dev_rg_ni.name
    id   = azurerm_network_interface.dev_rg_ni.id
  }
}