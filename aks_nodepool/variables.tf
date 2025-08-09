variable "name" {}
variable "kubernetes_cluster_id" {}
variable "vm_size" {}
variable "max_pods" {}
variable "os_type" {}
variable "mode" {}
variable "orchestrator_version" {}
variable "node_labels" {
  type    = map(string)
  default = {}
}
variable "node_taints" {
  type    = list(string)
  default = []
}
variable "zones" {
  type    = list(string)
  default = []
}
variable "vnet_subnet_id" {}
variable "enable_auto_scaling" {
  type    = bool
  default = false
}
variable "min_count" {
  type    = number
  default = 1
}
variable "max_count" {
  type    = number
  default = 3
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "node_pool_node_count" {
  description = "Initial node count for the default node pool"
  type        = number
  default     = 3
}

variable "node_pool_min_count" {
  description = "Minimum node count for auto-scaling"
  type        = number
  default     = 1
}

variable "node_pool_max_count" {
  description = "Maximum node count for auto-scaling"
  type        = number
  default     = 5
}

variable "node_pool_enable_auto_scaling" {
  description = "Enable auto-scaling for default node pool"
  type        = bool
  default     = false
}