# locals {
#   vm_instances = [
#     for i in range(var.vm_count) : {
#       name           = "vm${i + 1}"
#       public_ip_name = "vm${i + 1}-pip"
#       nic_name       = "vm${i + 1}-nic"
#       private_ip     = "10.0.2.${10 + i}"
#     }
#   ]
# }

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
# module "dev_rg_pubIP" {
#   for_each = { for vm in local.vm_instances : vm.public_ip_name => vm }


#   source = "./public_ip"

#   name = each.value.public_ip_name
#   allocation_method   = var.azure_publicip_config.allocation_method
#   resource_group_name = var.resource_group_info.name
#   location            = var.resource_group_info.location
# }
module "dev_rg_pubIP" {
  for_each = var.vm_specs # keys = vm names

  source              = "./public_ip"
  name                = "${each.key}-pip"
  allocation_method   = "Static"
  location            = var.resource_group_info.location
  resource_group_name = var.resource_group_info.name
}

# Network Interface
# module "dev_rg_ni" {
#   for_each = { for vm in local.vm_instances : vm.public_ip_name => vm }


#   source = "./nic"

#   name = each.value.nic_name
#   resource_group_info = {
#     name     = var.resource_group_info.name
#     location = var.resource_group_info.location
#   }
#   ip_configuration = {
#     name      = var.azure_ni_config.ip_configuration.name
#     subnet_id = module.dev_rg_subnet.subnets_info.id
#     private_ip_address_allocation = each.value.private_ip
#     public_ip_address_id          = module.dev_rg_pubIP[each.key].public_ip_info.id
#   }
# }
module "dev_rg_ni" {
  for_each = var.vm_specs

  source = "./nic"
  name   = "${each.key}-nic"

  resource_group_info = {
    name     = var.resource_group_info.name
    location = var.resource_group_info.location
  }

  ip_configuration = {
    name                          = "ipcfg"
    subnet_id                     = module.dev_rg_subnet.subnets_info.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address            = "10.0.2.${10 + index(keys(var.vm_specs), each.key)}"
    public_ip_address_id          = module.dev_rg_pubIP[each.key].public_ip_info.id
  }
}

# Azure LINUX VM
# module "dev_rg_vm1" {
#   for_each = { for vm in local.vm_instances : vm.public_ip_name => vm }

#   source = "./linux_vm"

#   vm_specs = var.vm_specs
#   azure_vm_config = merge(
#     var.azure_vm_config,
#     {
#       name                  = each.value.name
#       size                  = lookup(var.vm_specs, each.value.name, var.azure_vm_config.size)
#       network_interface_ids = [module.dev_rg_ni[each.key].network_interface_info.id]
#     }
#   )

#   resource_group_info = {
#     name     = var.resource_group_info.name
#     location = var.resource_group_info.location
#   }
# }

module "dev_rg_vm1" {
  for_each = var.vm_specs

  source = "./linux_vm"

  azure_vm_config = merge(
    var.azure_vm_config,
    {
      name = each.key
      size = each.value.size
      network_interface_ids = [
        module.dev_rg_ni[each.key].network_interface_info.id
      ]
    }
  )

  resource_group_info = {
    name     = var.resource_group_info.name
    location = var.resource_group_info.location
  }
}

# Network Security Groups
# module "nsg" {
#   for_each = module.dev_rg_ni

#   source = "./nsg"

#   azurerm_network_security_rule = [
#     for rule in var.azurerm_network_security_rule : merge(
#       rule,
#       {
#         resource_group_name         = var.resource_group_info.name
#         network_security_group_name = var.network_security_group_name
#       }
#     )
#   ]
#   application_security_group = {
#     name                = var.application_security_group_name
#     location            = var.resource_group_info.location
#     resource_group_name = var.resource_group_info.name
#   }

#   network_security_group = {
#     name                = var.network_security_group_name
#     location            = var.resource_group_info.location
#     resource_group_name = var.resource_group_info.name
#   }

#   nic_info = {
#     id = each.value.network_interface_info.id
#   }
# }

module "nsg" {
  for_each = module.dev_rg_ni          

  source = "./nsg"

  azurerm_network_security_rule = [
    for rule in var.azurerm_network_security_rule : merge(
      rule,
      {
        resource_group_name         = var.resource_group_info.name
        network_security_group_name = "${each.key}-nsg"
      }
    )
  ]

  application_security_group = {
    name                = "${each.key}-asg"    
    location            = var.resource_group_info.location
    resource_group_name = var.resource_group_info.name
  }

  network_security_group = {
    name                = "${each.key}-nsg"     
    location            = var.resource_group_info.location
    resource_group_name = var.resource_group_info.name
  }

  nic_info = {
    id = each.value.network_interface_info.id
  }
}