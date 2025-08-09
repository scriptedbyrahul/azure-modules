output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "kube_config" {
  description = "Kube config content to access AKS cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive   = true
}

output "kube_admin_config" {
  description = "Admin kube config content"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_admin_config_raw
  sensitive   = true
}

output "fqdn" {
  description = "The fully qualified domain name of the AKS API server"
  value       = azurerm_kubernetes_cluster.aks_cluster.fqdn
}
