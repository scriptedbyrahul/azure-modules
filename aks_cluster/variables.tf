variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure location for the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name where AKS will be deployed"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Enable private cluster"
  type        = bool
  default     = false
}

variable "local_account_disabled" {
  description = "Disable local accounts on the cluster"
  type        = bool
  default     = false
}

variable "rbac_enabled" {
  description = "Enable Kubernetes Role Based Access Control"
  type        = bool
  default     = true
}

variable "azure_rbac_enabled" {
  description = "Enable Azure RBAC for AKS"
  type        = bool
  default     = false
}

variable "authorized_ip_ranges" {
  description = "List of IP ranges authorized to access the API server"
  type        = list(string)
  default     = []
}

variable "default_node_pool_name" {
  description = "Name of the default node pool"
  type        = string
  default     = "default"
}

variable "default_node_pool_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "default_node_pool_node_count" {
  description = "Initial node count for the default node pool"
  type        = number
  default     = 3
}

variable "default_node_pool_os_disk_size_gb" {
  description = "OS disk size for the default node pool nodes"
  type        = number
  default     = 128
}

variable "default_node_pool_type" {
  description = "Node pool type"
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "default_node_pool_zones" {
  description = "Availability zones for default node pool"
  type        = list(string)
  default     = []
}

variable "default_node_pool_enable_auto_scaling" {
  description = "Enable auto-scaling for default node pool"
  type        = bool
  default     = false
}

variable "default_node_pool_min_count" {
  description = "Minimum node count for auto-scaling"
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Maximum node count for auto-scaling"
  type        = number
  default     = 5
}

variable "identity_type" {
  description = "AKS cluster identity type (SystemAssigned, UserAssigned, or None)"
  type        = string
  default     = "SystemAssigned"
}

variable "network_plugin" {
  description = "Network plugin (azure or kubenet)"
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy (calico or azure)"
  type        = string
  default     = null
  nullable    = true
}


variable "service_cidr" {
  description = "Service CIDR for Kubernetes services"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address for the DNS service"
  type        = string
  default     = "10.0.0.10"
}

variable "outbound_type" {
  description = "Outbound type (loadBalancer, userDefinedRouting)"
  type        = string
  default     = "loadBalancer"
}


variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
  default     = ""
}

variable "http_application_routing_enabled" {
  description = "Enable HTTP application routing addon"
  type        = bool
  default     = false
}

variable "azure_policy_enabled" {
  description = "Enable Azure Policy addon"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {}
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where AKS nodes will be deployed"
  type        = string
}

variable "admin_group_object_ids" {
  description = "List of Azure AD group object IDs for AKS admin access."
  type        = list(string)
  default     = []
}