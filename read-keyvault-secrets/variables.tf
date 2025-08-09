variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "Resource group where the Key Vault resides"
  type        = string
}

variable "secret_names" {
  description = "List of secret names to retrieve"
  type        = list(string)
}