output "secrets" {
  description = "Map of secret names to their values"
  sensitive   = true
  value = {
    for key, secret in data.azurerm_key_vault_secret.keyvault_secrets :
    key => secret.value
  }
}