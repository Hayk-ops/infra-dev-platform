variable "name" {
  description = "Subnet name"
  type        = string
}

variable "address_prefixes" {
  description = "Address prefixes"
  type        = list(string)
}

variable "virtual_network_name" {
  description = "For configuring subnet we need a Vnet name"
  type        = string
}

variable "resource_group_name" {
  description = "For configuring subnet we need a Resource group name"
  type        = string
}
