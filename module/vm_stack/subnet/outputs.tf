output "subnets_info" {
  value = {
    id               = azurerm_subnet.dev_rg_subnet.id
    name             = azurerm_subnet.dev_rg_subnet.name
    address_prefixes = azurerm_subnet.dev_rg_subnet.address_prefixes
  }
}