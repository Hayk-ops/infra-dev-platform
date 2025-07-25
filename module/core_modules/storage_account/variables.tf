variable "storage_account_config" {
  type = object({
    name                            = string
    account_tier                    = string
    account_kind                    = string
    account_replication_type        = string
    https_traffic_only_enabled      = bool
    access_tier                     = string
    allow_nested_items_to_be_public = bool
  })
}

variable "azurerm_storage_container_config" {
  type = object({
    name                  = string
    container_access_type = string
  })
}

variable "resource_group_info" {
  type = object({
    name     = string
    location = string
  })
}

variable "subscription_id" {
  type = string
}

variable "principal_id" {
  type = string
}