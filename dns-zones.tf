resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = {
    for link in var.private_dns_zones : link.link_name => link
  }

  name                  = each.value.link_name
  resource_group_name   = each.value.resource_group_name != "" ? each.value.resource_group_name : var.resource_group_name
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].id : azurerm_virtual_network.ignored_subnet_management[0].id
  registration_enabled  = each.value.registration_enabled

  tags = merge(local.metadata.tags, each.value.tags)

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_private_dns_zone_virtual_network_link"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_private_dns_zone_virtual_network_link"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_private_dns_zone_virtual_network_link"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_private_dns_zone_virtual_network_link"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}