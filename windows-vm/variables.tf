variable "name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "location" {
  type        = string
  description = "The azure location"
}


variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "admin username"
  type        = string
  default     = null
}

variable "admin_password" {
  description = "admin password"
  type        = string
  default     = null
}

variable "admin_ssh_key" {
  description = "admin public ssh key"
  type        = string
  default     = null
}

variable "priority" {
  type        = string
  description = " Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created. Changing the priority to spot, enables the spot market."
  default     = "Regular"
}

variable "max_bid_price" {
  type        = string
  description = "The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons."
  default     = "-1"
}

variable "eviction_policy" {
  type        = string
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. At this time the only supported value is Deallocate. Changing this forces a new resource to be created."
  default     = null
}

variable "network_interface_ids" {
  type    = list(string)
  default = null
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = number
  })
}

variable "image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "tags" {
  description = "tags set "
  type        = map(string)
  default     = {}
}

variable "subnet_id" {

}

variable "dns_servers" {
  type    = list(string)
  default = ["192.168.0.100"]
}

variable "enable_accelerated_networking" {
  type    = bool
  default = false
}

variable "public_ip_ids" {
  type    = list(string)
  default = []
}

variable "custom_data_file" {
  description = "Path to a custom data script file (e.g., cloud-init or shell script)"
  type        = string
  default     = null
}

variable "network_security_group_id" {
  description = "Optional NSG to attach to NIC"
  type        = string
  default     = null
}

variable "associate_nsg" {
  type    = bool
  default = false
}
