output "disk_id" {
  description = "The ID of the managed disk"
  value       = azurerm_managed_disk.managed_disk.id
}

output "disk_name" {
  description = "The name of the managed disk"
  value       = azurerm_managed_disk.managed_disk.name
}
