output "azurerm_resource_group_values" {
  value = module.resource_group_core.resource_group_info
}


# k8s_cluster module
output "virtual_network_info" {
  value = module.k8s_cluster.virtual_network_info
}

output "azurerm_subnet_values" {
  value = module.k8s_cluster.azurerm_subnet_values
}

output "azurerm_public_ip_values" {
  value = module.k8s_cluster.azurerm_public_ip_values
}

output "azurerm_network_interface_values" {
  value = module.k8s_cluster.azurerm_network_interface_values
}

output "azurerm_linux_virtual_machine_values" {
  value = module.k8s_cluster.azurerm_linux_virtual_machine_values
}

# Azure VAULT
output "key_vault_values" {
  value = module.azure_key_vault.key_vault_info
}

# Azure Container Registry
output "acr_login_server" {
  value = module.ac_registry.login_server
}

# AKS cluster 1
# output "kube_config_raw" {
#   value     = module.hayk_aks_dev.kube_config_raw
#   sensitive = true
# }

# output "client_certificate" {
#   value     = module.hayk_aks_dev.client_certificate
#   sensitive = true
# }

# output "cluster_name" {
#   value = module.hayk_aks_dev.cluster_name
# }

# output "kubernetes_version" {
#   value = module.hayk_aks_dev.kubernetes_version
# }

# output "node_resource_group" {
#   value = module.hayk_aks_dev.node_resource_group
# }

# output "identity_principal_id" {
#   value = module.hayk_aks_dev.identity_principal_id
# }