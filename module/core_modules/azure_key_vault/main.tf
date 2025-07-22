# data "azurerm_client_config" "current" {}

# provider "azuread" {
#   tenant_id = data.azurerm_client_config.current.tenant_id
# }

resource "azurerm_key_vault" "key_vault_dev_core" {
  name                = var.key_vault_dev_core_config.name
  resource_group_name = var.key_vault_dev_core_config.resource_group_name
  location            = var.key_vault_dev_core_config.location
  tenant_id           = var.tenant_id

  sku_name = var.key_vault_dev_core_config.sku_name
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.key_vault_dev_core.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  secret_permissions      = var.secret_permissions_current_user
  certificate_permissions = var.certificate_permissions_current_user
}

resource "azurerm_key_vault_access_policy" "github_oidc" {
  key_vault_id = azurerm_key_vault.key_vault_dev_core.id
  tenant_id    = "5582754b-038d-486a-a2f6-b76933c834fb" # Tenant ID
  object_id    = "05e99ec4-438f-4bdb-b1ca-7ac14d901c9c" # GitHub OIDC App Object ID

  secret_permissions = ["Get", "List", "Set", "Delete"]
  certificate_permissions = ["Get", "List", "Import"]
}

resource "azurerm_key_vault_access_policy" "microsoft_web" {
  key_vault_id = azurerm_key_vault.key_vault_dev_core.id
  tenant_id    = azurerm_key_vault.key_vault_dev_core.tenant_id

  object_id = var.microsoft_web_object_id

  secret_permissions      = ["Get"]
  certificate_permissions = ["Get"]
}

resource "azurerm_app_service_certificate" "azurerm_svc_cert" {
  name                = var.azurerm_svc_cert_config.name
  resource_group_name = var.azurerm_svc_cert_config.resource_group_name
  location            = var.azurerm_svc_cert_config.location
  key_vault_secret_id = var.azurerm_svc_cert_secret_id
}
