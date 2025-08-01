resource "azurerm_network_security_rule" "dev_rg_net_sec_rule" {
  for_each = { for rule in var.azurerm_network_security_rule : rule.name => rule }

  name                       = each.value.name
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix

  resource_group_name         = each.value.resource_group_name
  network_security_group_name = each.value.network_security_group_name

  depends_on = [
    azurerm_network_security_group.dev_rg_net_sec_group
  ]
}

resource "azurerm_application_security_group" "dev_rg_sec_group" {
  name                = var.application_security_group.name
  location            = var.application_security_group.location
  resource_group_name = var.application_security_group.resource_group_name
}

resource "azurerm_network_security_group" "dev_rg_net_sec_group" {
  name                = var.network_security_group.name
  location            = var.network_security_group.location
  resource_group_name = var.network_security_group.resource_group_name
}

# resource "azurerm_network_interface_security_group_association" "dev_rg_nic_nsg_assoc" {
#   network_interface_id      = var.network_interface_security_group_association.network_interface_id
#   network_security_group_id = var.network_interface_security_group_association.network_security_group_id
# }

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = var.nic_info.id
  network_security_group_id = azurerm_network_security_group.dev_rg_net_sec_group.id
}