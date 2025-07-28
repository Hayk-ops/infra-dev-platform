resource "azurerm_key_vault" "key_vault_dev_core" {
  name                = var.key_vault_dev_core_config.name
  resource_group_name = var.key_vault_dev_core_config.resource_group_name
  location            = var.key_vault_dev_core_config.location
  tenant_id           = var.tenant_id
  sku_name            = var.key_vault_dev_core_config.sku_name

  enable_rbac_authorization = true

}

resource "azurerm_role_assignment" "ci_secrets_officer" {
  scope                = azurerm_key_vault.key_vault_dev_core.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.github_oidc_secrets_officer_id
}

resource "azurerm_role_assignment" "ci_uaa" {
  scope                = azurerm_key_vault.key_vault_dev_core.id
  role_definition_name = "User Access Administrator"
  principal_id         = var.github_oidc_secrets_officer_id
}


resource "azurerm_role_assignment" "current_user" {
  scope                = azurerm_key_vault.key_vault_dev_core.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.object_id
}

# resource "azurerm_role_assignment" "kv_readers" {
#   for_each             = var.kv_reader_ids
#   scope                = azurerm_key_vault.key_vault_dev_core.id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value

#   # 🔑 FIX: correct usage of principal_type
#   principal_type = each.key == "user" ? "User" : "ServicePrincipal"

#   skip_service_principal_aad_check = true

# }

# resource "azurerm_role_assignment" "app_service_certificate_access" {
#   scope                = azurerm_key_vault.key_vault_dev_core.id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = "abfa0a7c-a6b6-4736-8310-5855508787cd"
# }

resource "azurerm_app_service_certificate" "azurerm_svc_cert" {
  name                = var.azurerm_svc_cert_config.name
  resource_group_name = var.azurerm_svc_cert_config.resource_group_name
  location            = var.azurerm_svc_cert_config.location
  key_vault_secret_id = var.azurerm_svc_cert_secret_id
}
