resource "azurerm_network_interface" "nic" {
  name                           = "${var.name}-nic"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  dns_servers                    = var.dns_servers
  accelerated_networking_enabled = var.enable_accelerated_networking

  dynamic "ip_configuration" {
    for_each = length(var.public_ip_ids) > 0 ? var.public_ip_ids : [null]
    content {
      name                          = "ipconfig-${ip_configuration.key}"
      subnet_id                     = var.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = ip_configuration.value
    }
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  count = var.associate_nsg ? 1 : 0

  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  custom_data = var.custom_data_file != null ? base64encode(var.custom_data_file) : null

  priority        = var.priority
  max_bid_price   = var.max_bid_price
  eviction_policy = var.eviction_policy != "" ? var.eviction_policy : null

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.image_reference.publisher
    offer     = var.image_reference.offer
    sku       = var.image_reference.sku
    version   = var.image_reference.version
  }

  tags = var.tags

}