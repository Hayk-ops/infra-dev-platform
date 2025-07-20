output "key_vault_info" {
  description = "Grouped outputs for Key Vault"
  value = {
    id   = azurerm_key_vault.key_vault_dev_core.id
    name = azurerm_key_vault.key_vault_dev_core.name
    uri  = azurerm_key_vault.key_vault_dev_core.vault_uri
  }
}