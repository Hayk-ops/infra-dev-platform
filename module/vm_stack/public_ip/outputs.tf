output "public_ip_info" {
  value = {
    name                = azurerm_public_ip.dev_rg_pubIP.name
    allocation_method   = azurerm_public_ip.dev_rg_pubIP.allocation_method
    resource_group_name = azurerm_public_ip.dev_rg_pubIP.resource_group_name
    location            = azurerm_public_ip.dev_rg_pubIP.location
    id                  = azurerm_public_ip.dev_rg_pubIP.id
  }
}