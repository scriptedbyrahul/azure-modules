variable "name" {
  description = "Name of the public IP"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "allocation_method" {
  description = "Public IP allocation method: Static or Dynamic"
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "SKU of the Public IP: Basic or Standard"
  type        = string
  default     = "Standard"
}

variable "sku_tier" {
  description = "The SKU Tier of the Public IP"
  type        = string
  default     = null
}