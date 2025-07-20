resource "azurerm_network_interface" "dev_rg_ni" {
  name                = var.name
  location            = var.resource_group_info.location
  resource_group_name = var.resource_group_info.name

  ip_configuration {
    name                          = var.ip_configuration.name
    subnet_id                     = var.ip_configuration.subnet_id
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = var.ip_configuration.public_ip_address_id
  }
}