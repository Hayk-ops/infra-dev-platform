resource "azurerm_kubernetes_cluster" "hayk_dev_aks" {
  name                = var.cluster_name
  location            = var.resource_group_info.location
  resource_group_name = var.resource_group_info.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    vm_size    = var.default_node_pool.vm_size
    type       = var.default_node_pool.type
    # zones      = var.default_node_pool.zones
    upgrade_settings {
      max_surge       = "1"
    }
  }

  identity {
    type = var.identity.type
  }

  tags = {
    Environment = var.tags.environment
  }
}
