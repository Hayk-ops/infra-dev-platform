output "kube_config_raw" {
  description = "Full raw kubeconfig for kubectl"
  value       = azurerm_kubernetes_cluster.hayk_dev_aks.kube_config_raw
  sensitive   = true
}

output "client_certificate" {
  description = "Client certificate for authentication"
  value       = azurerm_kubernetes_cluster.hayk_dev_aks.kube_config[0].client_certificate
  sensitive   = true
}

output "cluster_name" {
  description = "AKS Cluster name"
  value       = azurerm_kubernetes_cluster.hayk_dev_aks.name
}

output "kubernetes_version" {
  description = "Kubernetes version of the cluster"
  value       = azurerm_kubernetes_cluster.hayk_dev_aks.kubernetes_version
}

output "node_resource_group" {
  description = "The name of the node resource group created by AKS"
  value       = azurerm_kubernetes_cluster.hayk_dev_aks.node_resource_group
}

output "identity_principal_id" {
  description = "The principal ID of the AKS system-assigned identity"
  value       = azurerm_kubernetes_cluster.hayk_dev_aks.identity[0].principal_id
}
