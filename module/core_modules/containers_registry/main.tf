resource "azurerm_container_registry" "haykdevacr" {
  name                = var.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = var.sku

  admin_enabled = false
}

resource "azurerm_role_assignment" "github_push" {
  scope                = azurerm_container_registry.haykdevacr.id
  role_definition_name = "AcrPush"
  principal_id         = var.github_oidc_object_id
}