output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.id
  }
}

output "subnet_names" {
  description = "Map of subnet keys to subnet resource names"
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.name
  }
}

output "subnet_address_prefixes" {
  description = "Map of subnet names to their address prefixes"
  value = {
    for k, subnet in azurerm_subnet.subnet :
    k => subnet.address_prefixes
  }
}