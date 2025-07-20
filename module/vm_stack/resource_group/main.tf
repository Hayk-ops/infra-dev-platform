resource "azurerm_resource_group" "dev_rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
