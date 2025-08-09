resource "azurerm_managed_disk" "managed_disk" {
  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "managed_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.managed_disk.id
  virtual_machine_id = var.virtual_machine_id
  lun                = var.lun
  caching            = var.caching
  create_option      = "Attach"
}