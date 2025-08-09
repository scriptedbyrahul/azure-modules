variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "security_rules" {
  description = "List of security rules for the NSG"
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  default = []
}

variable "subnet_id" {
  description = "ID of the subnet to associate NSG with"
  type        = string
}

variable "location" {
  type        = string
  description = "Azure region"
}
