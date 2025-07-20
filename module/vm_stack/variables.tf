variable "resource_group_info" {
  type = object({
    name     = string
    location = string
    tags     = map(string)
  })
}

variable "azure_vnet_config" {
  description = "Configuration for Azure virtual network"
  type = object({
    name          = string
    address_space = list(string)
  })
}

variable "azure_publicip_config" {
  description = "Configuration for Azure Public IP"
  type = object({
    name              = string
    allocation_method = string
  })
}

variable "azure_subnet_config" {
  description = "Configuration for Azure subnet"
  type = object({
    name             = string
    address_prefixes = list(string)
  })
}

variable "azure_ni_config" {
  description = "Configuration for Azure Network Interface"
  type = object({
    name = string
    ip_configuration = object({
      name                          = string
      private_ip_address_allocation = string
    })
  })
}

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

variable "azurerm_network_security_rule" {
  description = "Azure network security rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "application_security_group_name" {
  description = "The Name of the Azure Application Security Group"
  type        = string
}

variable "network_security_group_name" {
  description = "The Name of the Azure Network Security Group"
  type        = string
}

