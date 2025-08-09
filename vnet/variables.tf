variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
  default     = "myVnet"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for VNet"
  default     = ["192.168.0.0/16"]
}

/*variable "public_subnet_prefix" {
  type        = string
  description = "Public subnet CIDR block"
  default     = "192.168.0.128/28"
}

variable "private_subnet_prefix" {
  type        = string
  description = "Private subnet CIDR block"
  default     = "192.168.0.96/27"
}*/

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    enable_nat       = bool
  }))
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}
