variable "name" {
  description = "The name of the managed disk"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "storage_account_type" {
  description = "The type of storage account (e.g., Standard_LRS, Premium_LRS)"
  type        = string
}

variable "create_option" {
  description = "The create option (e.g., Empty, Import, Copy, Restore, FromImage)"
  type        = string
  default     = "Empty"
}

variable "disk_size_gb" {
  description = "The size of the managed disk in GB"
  type        = number
}

variable "virtual_machine_id" {
  description = "The ID of the virtual machine to attach the disk to"
  type        = string
}

variable "lun" {
  description = "Logical unit number of the data disk (must be unique per VM)"
  type        = number
}

variable "caching" {
  description = "Caching type (None, ReadOnly, ReadWrite)"
  type        = string
  default     = "ReadOnly"
}
