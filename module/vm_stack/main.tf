# Virtual Network
module "dev_rg_net" {
  source = "./vnet"

  name                = var.azure_vnet_config.name
  address_space       = var.azure_vnet_config.address_space
  location            = var.resource_group_info.location
  resource_group_name = var.resource_group_info.name
}

# Subnet
module "dev_rg_subnet" {
  source = "./subnet"

  name                 = var.azure_subnet_config.name
  address_prefixes     = var.azure_subnet_config.address_prefixes
  virtual_network_name = module.dev_rg_net.virtual_network_info.name
  resource_group_name  = var.resource_group_info.name
}

# Public IP
module "dev_rg_pubIP" {
  source = "./public_ip"

  name                = var.azure_publicip_config.name
  allocation_method   = var.azure_publicip_config.allocation_method
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location
}

# Network Interface
module "dev_rg_ni" {
  source = "./nic"

  name = var.azure_ni_config.name
  resource_group_info = {
    name     = var.resource_group_info.name
    location = var.resource_group_info.location
  }
  ip_configuration = {
    name                          = var.azure_ni_config.ip_configuration.name
    subnet_id                     = module.dev_rg_subnet.subnets_info.id
    private_ip_address_allocation = var.azure_ni_config.ip_configuration.private_ip_address_allocation
    public_ip_address_id          = module.dev_rg_pubIP.public_ip_info.id
  }
}

# Azure LINUX VM
module "dev_rg_vm1" {
  source = "./linux_vm"

  azure_vm_config = merge(
    var.azure_vm_config,
    {
      network_interface_ids = [module.dev_rg_ni.network_interface_info.id]
    }
  )

  resource_group_info = {
    name     = var.resource_group_info.name
    location = var.resource_group_info.location
  }
}

# Network Security Groups
module "nsg" {
  source = "./nsg"

  azurerm_network_security_rule = [
    for rule in var.azurerm_network_security_rule : merge(
      rule,
      {
        resource_group_name         = var.resource_group_info.name
        network_security_group_name = var.network_security_group_name
      }
    )
  ]
  application_security_group = {
    name                = var.application_security_group_name
    location            = var.resource_group_info.location
    resource_group_name = var.resource_group_info.name
  }

  network_security_group = {
    name                = var.network_security_group_name
    location            = var.resource_group_info.location
    resource_group_name = var.resource_group_info.name
  }
  network_interface_security_group_association = {
    network_interface_id      = module.dev_rg_ni.network_interface_info.id
    network_security_group_id = module.nsg.network_security_group_info.id
  }
}
