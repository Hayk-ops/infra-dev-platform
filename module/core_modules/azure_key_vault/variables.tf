variable "key_vault_dev_core_config" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    sku_name            = string
  })
}

variable "certificate_permissions" {
  type = list(string)
}

variable "web_app_resource_provider_config" {
  type = object({
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  })
}

variable "azurerm_svc_cert_config" {
  type = object({
    name                = string
    resource_group_name = string
    location            = string
  })
}

variable "web_app_resource_provider_client_id" {
  type = string
}

variable "microsoft_web_object_id" {
  type = string
}

variable "azurerm_svc_cert_secret_id" {
  type = string
}

variable "secret_permissions_current_user" {
  type = list(string)
}

variable "certificate_permissions_current_user" {
  type = list(string)
}

variable "tenant_id" {
  type = string
}

variable "object_id" {
  type = string
}