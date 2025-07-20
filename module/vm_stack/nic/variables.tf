variable "name" {
  description = "Resource name"
  type        = string
}

variable "resource_group_info" {
  description = "Resource group location and Name"
  type = object({
    name     = string
    location = string
  })
}

variable "ip_configuration" {
  description = "IP configuration for tests"
  type = object({
    name                          = string
    subnet_id                     = string
    public_ip_address_id          = string
    private_ip_address_allocation = string
  })
}