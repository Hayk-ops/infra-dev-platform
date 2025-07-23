output "azurerm_resource_group_values" {
  value = module.resource_group_core.resource_group_info
}

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

output "azurerm_linux_virtual_machine" {
  value = module.vm_stack.azurerm_linux_virtual_machine
}

# Azure VAULT
output "key_vault_values" {
  value = module.azure_key_vault.key_vault_info
}

