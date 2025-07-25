resource "azurerm_storage_account" "devhaykstorageacct" {
  name                = var.storage_account_config.name
  resource_group_name = var.resource_group_info.name
  location            = var.resource_group_info.location

  account_tier                    = var.storage_account_config.account_tier
  account_kind                    = var.storage_account_config.account_kind
  account_replication_type        = var.storage_account_config.account_replication_type
  https_traffic_only_enabled      = var.storage_account_config.https_traffic_only_enabled
  access_tier                     = var.storage_account_config.access_tier
  allow_nested_items_to_be_public = var.storage_account_config.allow_nested_items_to_be_public
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.azurerm_storage_container_config.name
  storage_account_id    = azurerm_storage_account.devhaykstorageacct.id
  container_access_type = var.azurerm_storage_container_config.container_access_type
}

resource "azurerm_role_assignment" "blob_data_contributor" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_info.name}/providers/Microsoft.Storage/storageAccounts/${var.storage_account_config.name}"
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}

resource "azurerm_role_assignment" "sa_reader" {		
scope = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_info.name}"		
role_definition_name = "Reader"		
principal_id = var.principal_id		
}