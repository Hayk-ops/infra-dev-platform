output "virtual_network_info" {
  value = module.dev_rg_net.virtual_network_info
}

output "azurerm_subnet_values" {
  value = module.dev_rg_subnet.subnets_info
}

output "azurerm_public_ip_values" {
  value = { for k, m in module.dev_rg_pubIP : k => m.public_ip_info }
}

output "azurerm_network_interface_values" {
  value = { for k, m in module.dev_rg_ni : k => m.network_interface_info }
}

output "azurerm_linux_virtual_machine_values" {
  value = { for k, m in module.dev_rg_vm1 : k => m.azurerm_linux_virtual_machine }
}