data "azurerm_key_vault" "keyvault" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "keyvault_secrets" {
  for_each     = toset(var.secret_names)
  name         = each.key
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
