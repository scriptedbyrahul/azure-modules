resource "azurerm_network_interface" "nic" {
  name                           = "${var.name}-nic"
  location                       = var.location
  resource_group_name            = var.resource_group_name
  dns_servers                    = var.dns_servers
  accelerated_networking_enabled = var.enable_accelerated_networking

  ip_configuration {
    name                          = "${var.name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = length(var.public_ip_ids) > 0 ? var.public_ip_ids[0] : null
  }

  lifecycle {
    ignore_changes = [ip_configuration]
  }

}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  count = var.associate_nsg ? 1 : 0

  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]
  priority              = var.priority
  max_bid_price         = var.max_bid_price
  eviction_policy       = var.eviction_policy
  custom_data           = var.custom_data_file != null ? base64encode(var.custom_data_file) : null

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  admin_username = var.admin_username

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



