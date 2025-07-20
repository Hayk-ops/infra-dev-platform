variable "name" {
  description = "resource name"
  type        = string
}

variable "address_space" {
  description = "The network address scope"
  type        = list(string)
}

variable "resource_group_name" {
  description = "The resource group name is requried to make this resource"
  type        = string
}

variable "location" {
  description = "The resource group location is requried to make this resource"
  type        = string
}