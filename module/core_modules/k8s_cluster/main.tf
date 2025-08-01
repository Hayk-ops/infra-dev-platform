

module "vm_stack" {
  source = "../../vm_stack"

  resource_group_info   = var.resource_group_info
  azure_vnet_config     = var.azure_vnet_config
  azure_publicip_config = var.azure_publicip_config
  azure_subnet_config   = var.azure_subnet_config
  azure_ni_config       = var.azure_ni_config
  vm_count              = var.vm_count
  vm_specs              = var.vm_specs
  azure_vm_config = merge(
    var.azure_vm_config,
    {
      admin_ssh_key = merge(
        try(var.azure_vm_config.admin_ssh_key, {}),
        {
          public_key = var.public_key_value
        }
      )
    }
  )
  azurerm_network_security_rule = [
    for rule in var.azurerm_network_security_rule : merge(
      rule,
      {
        resource_group_name         = var.resource_group_info.name,
        network_security_group_name = var.network_security_group_name
      }
    )
  ]
  application_security_group_name = var.application_security_group_name
  network_security_group_name     = var.network_security_group_name
}