resource "azurerm_linux_virtual_machine" "dev_rg_vm1" {
  name                            = var.azure_vm_config.name
  resource_group_name             = var.resource_group_info.name
  location                        = var.resource_group_info.location
  size                            = var.azure_vm_config.size
  admin_username                  = var.azure_vm_config.admin_username
  disable_password_authentication = var.azure_vm_config.disable_password_authentication

  admin_ssh_key {
    username   = var.azure_vm_config.admin_ssh_key.username
    public_key = var.azure_vm_config.admin_ssh_key.public_key
  }

  network_interface_ids = var.azure_vm_config.network_interface_ids

  source_image_reference {
    publisher = var.azure_vm_config.source_image_reference.publisher
    offer     = var.azure_vm_config.source_image_reference.offer
    sku       = var.azure_vm_config.source_image_reference.sku
    version   = var.azure_vm_config.source_image_reference.version
  }

  os_disk {
    storage_account_type = var.azure_vm_config.os_disk.storage_account_type
    caching              = var.azure_vm_config.os_disk.caching
  }
}