resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  kubernetes_version      = var.kubernetes_version
  private_cluster_enabled = var.private_cluster_enabled

  local_account_disabled            = var.local_account_disabled
  role_based_access_control_enabled = var.rbac_enabled

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = var.azure_rbac_enabled
  }

  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }

  default_node_pool {
    name                 = var.default_node_pool_name
    vm_size              = var.default_node_pool_vm_size
    node_count           = var.default_node_pool_enable_auto_scaling ? null : var.default_node_pool_node_count
    min_count            = var.default_node_pool_enable_auto_scaling ? var.default_node_pool_min_count : null
    max_count            = var.default_node_pool_enable_auto_scaling ? var.default_node_pool_max_count : null
    os_disk_size_gb      = var.default_node_pool_os_disk_size_gb
    type                 = var.default_node_pool_type
    zones                = var.default_node_pool_zones
    orchestrator_version = var.kubernetes_version
    vnet_subnet_id       = var.vnet_subnet_id

    node_labels = {
      "nodepool" = "defaultnodepool"
    }

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }

    auto_scaling_enabled = var.default_node_pool_enable_auto_scaling
  }

  identity {
    type = var.identity_type
  }

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
    outbound_type  = var.outbound_type
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  http_application_routing_enabled = var.http_application_routing_enabled
  azure_policy_enabled             = var.azure_policy_enabled

  tags = var.tags
}
