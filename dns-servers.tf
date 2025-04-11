resource "azurerm_virtual_network_dns_servers" "this" {
  count              = length(var.dns_servers) > 0 ? 1 : 0
  virtual_network_id = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].id : azurerm_virtual_network.ignored_subnet_management[0].id
  dns_servers        = var.dns_servers

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_dns_servers"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_dns_servers"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_dns_servers"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_dns_servers"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}