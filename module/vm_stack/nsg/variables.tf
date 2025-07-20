variable "azurerm_network_security_rule" {
  description = "Azure network security rules"
  type = list(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
    resource_group_name         = string
    network_security_group_name = string
  }))
}

variable "application_security_group" {
  description = "Azure Application Security Group"
  type = object({
    name                = string
    location            = string
    resource_group_name = string
  })
}

variable "network_security_group" {
  description = "Network Security Group"
  type = object({
    name                = string
    location            = string
    resource_group_name = string
  })
}

variable "network_interface_security_group_association" {
  description = "Network Interface Security Group Association"
  type = object({
    network_interface_id      = string
    network_security_group_id = string
  })
}