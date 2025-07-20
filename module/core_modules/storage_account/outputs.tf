output "azurerm_storage_account_info" {
  value = {
    name                     = azurerm_storage_account.devhaykstorageacct.name
    account_tier             = azurerm_storage_account.devhaykstorageacct.account_tier
    account_kind             = azurerm_storage_account.devhaykstorageacct.account_kind
    account_replication_type = azurerm_storage_account.devhaykstorageacct.account_replication_type
  }
}

output "azurerm_storage_container_info" {
  value = {
    name                  = azurerm_storage_container.tfstate.name
    container_access_type = azurerm_storage_container.tfstate.container_access_type
  }
}