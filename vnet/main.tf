locals {
  nat_enabled_subnets = {
    for k, v in var.subnets : k => v if v.enable_nat == true
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_public_ip" "nat_ip" {
  for_each            = local.nat_enabled_subnets
  name                = "${var.vnet_name}-${each.key}-nat-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gw" {
  for_each            = local.nat_enabled_subnets
  name                = "${var.vnet_name}-${each.key}-nat-gw"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_ip_assoc" {
  for_each             = local.nat_enabled_subnets
  nat_gateway_id       = azurerm_nat_gateway.nat_gw[each.key].id
  public_ip_address_id = azurerm_public_ip.nat_ip[each.key].id
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = "${var.vnet_name}-${each.value.name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_subnet_nat_gateway_association" "nat_subnet_assoc" {
  for_each       = local.nat_enabled_subnets
  subnet_id      = azurerm_subnet.subnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat_gw[each.key].id
}