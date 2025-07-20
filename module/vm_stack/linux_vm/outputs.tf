output "azurerm_linux_virtual_machine" {
  value = {
    name           = azurerm_linux_virtual_machine.dev_rg_vm1.name
    admin_username = azurerm_linux_virtual_machine.dev_rg_vm1.admin_username
    source_image_reference = {
      publisher = azurerm_linux_virtual_machine.dev_rg_vm1.source_image_reference[0].publisher
      sku       = azurerm_linux_virtual_machine.dev_rg_vm1.source_image_reference[0].sku
      version   = azurerm_linux_virtual_machine.dev_rg_vm1.source_image_reference[0].version
      offer     = azurerm_linux_virtual_machine.dev_rg_vm1.source_image_reference[0].offer
    }
  }
}