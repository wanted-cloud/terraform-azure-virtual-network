resource "azurerm_virtual_network_peering" "from" {
  for_each = {
    for peering in var.virtual_network_peerings : "${peering.name}-from" => peering
    if peering.type == "from" || peering.type == "both"
  }
  name                      = "${each.value.name}-from"
  resource_group_name       = data.azurerm_resource_group.this.name
  virtual_network_name      = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].id : azurerm_virtual_network.ignored_subnet_management[0].id
  remote_virtual_network_id = each.value.remote_virtual_network_id

  allow_virtual_network_access           = each.value.allow_virtual_network_access
  allow_forwarded_traffic                = each.value.allow_forwarded_traffic
  allow_gateway_transit                  = each.value.allow_gateway_transit
  use_remote_gateways                    = each.value.use_remote_gateways
  local_subnet_names                     = each.value.local_subnet_names
  remote_subnet_names                    = each.value.remote_subnet_names
  only_ipv6_peering_enabled              = each.value.only_ipv6_peering_enabled
  peer_complete_virtual_networks_enabled = each.value.peer_complete_virtual_networks_enabled
  triggers                               = each.value.triggers

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}

resource "azurerm_virtual_network_peering" "to" {
  for_each = {
    for peering in var.virtual_network_peerings : "${peering.name}-to" => peering
    if peering.type == "to" || peering.type == "both"
  }

  name                      = "${each.value.name}-to"
  resource_group_name       = split("/", each.value.remote_virtual_network_id)[4]
  virtual_network_name      = split("/", each.value.remote_virtual_network_id)[8]
  remote_virtual_network_id = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].id : azurerm_virtual_network.ignored_subnet_management[0].id

  allow_virtual_network_access           = each.value.allow_virtual_network_access
  allow_forwarded_traffic                = each.value.allow_forwarded_traffic
  allow_gateway_transit                  = each.value.allow_gateway_transit
  use_remote_gateways                    = each.value.use_remote_gateways
  local_subnet_names                     = each.value.local_subnet_names
  remote_subnet_names                    = each.value.remote_subnet_names
  only_ipv6_peering_enabled              = each.value.only_ipv6_peering_enabled
  peer_complete_virtual_networks_enabled = each.value.peer_complete_virtual_networks_enabled
  triggers                               = each.value.triggers

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_virtual_network_peering"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}