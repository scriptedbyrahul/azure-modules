resource "azurerm_kubernetes_cluster_node_pool" "aks_nodepool" {
  name                  = var.name
  kubernetes_cluster_id = var.kubernetes_cluster_id
  vm_size               = var.vm_size
  max_pods              = var.max_pods
  os_type               = var.os_type
  mode                  = var.mode
  orchestrator_version  = var.orchestrator_version
  node_labels           = var.node_labels
  node_taints           = var.node_taints
  zones                 = var.zones
  vnet_subnet_id        = var.vnet_subnet_id

  auto_scaling_enabled = var.node_pool_enable_auto_scaling
  node_count           = var.node_pool_enable_auto_scaling ? null : var.node_pool_node_count
  min_count            = var.node_pool_enable_auto_scaling ? var.node_pool_min_count : null
  max_count            = var.node_pool_enable_auto_scaling ? var.node_pool_max_count : null

  tags = var.tags
}