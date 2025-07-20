variable "azure_vm_config" {
  description = "Configuration of VM"
  type = object({
    name                            = string
    size                            = string
    admin_username                  = string
    disable_password_authentication = bool
    admin_ssh_key = object({
      username   = string
      public_key = string
    })
    network_interface_ids = list(string)
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      storage_account_type = string
      caching              = string
    })
  })
}

variable "resource_group_info" {
  description = "Resource group required data"
  type = object({
    name     = string
    location = string
  })
}
