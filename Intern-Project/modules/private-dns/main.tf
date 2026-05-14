resource "azurerm_private_dns_zone" "this" {
  for_each = toset(var.dns_zones)
  
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = toset(var.dns_zones)
  
  name                  = "${replace(each.value, ".", "-")}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.value].name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
  tags                  = var.tags
}