output "virtual_network_info" {
  value = module.vm_stack.virtual_network_info
}

output "azurerm_subnet_values" {
  value = module.vm_stack.azurerm_subnet_values
}

output "azurerm_public_ip_values" {
  value = module.vm_stack.azurerm_public_ip_values
}

output "azurerm_network_interface_values" {
  value = module.vm_stack.azurerm_network_interface_values
}

output "azurerm_linux_virtual_machine_values" {
  value = module.vm_stack.azurerm_linux_virtual_machine_values
}
