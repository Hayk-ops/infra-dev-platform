variable "name" {
  description = "The name of public ip"
  type        = string
}

variable "allocation_method" {
  type = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Resource Group location"
  type        = string
}