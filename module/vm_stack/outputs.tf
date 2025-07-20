output "virtual_network_info" {
  value = module.dev_rg_net.virtual_network_info
}

output "azurerm_subnet_values" {
  value = module.dev_rg_subnet.subnets_info
}

output "azurerm_public_ip_values" {
  value = module.dev_rg_pubIP.public_ip_info
}

output "azurerm_network_interface_values" {
  value = module.dev_rg_ni.network_interface_info
}


output "azurerm_linux_virtual_machine" {
  value = module.dev_rg_vm1.azurerm_linux_virtual_machine
}