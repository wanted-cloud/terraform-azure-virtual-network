resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = {
    for link in var.private_dns_zones : link.link_name => link
  }

  name                  = each.value.link_name
  resource_group_name   = each.value.resource_group_name != "" ? each.value.resource_group_name : var.resource_group_name
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = azurerm_virtual_network.this.id
}