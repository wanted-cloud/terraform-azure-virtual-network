/**
 * # wanted-cloud/terraform-azure-virtual-network
 *
 * Terraform building block for creation and management of Azure Virtual Network and related resources.
 *
 */
resource "azurerm_virtual_network" "this" {
  count               = var.subnet_management_enabled == true ? 1 : 0
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.address_spaces
  bgp_community       = var.bgp_community != "" ? var.bgp_community : null
  edge_zone           = var.edge_zone != "" ? var.edge_zone : null
  tags                = merge(local.metadata.tags, var.tags)

  // To not cause conflict with azurerm_virtual_network_dns_servers this should never be set
  dns_servers = []

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}

resource "azurerm_virtual_network" "ignored_subnet_management" {
  count               = var.subnet_management_enabled == true ? 0 : 1
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.address_spaces
  bgp_community       = var.bgp_community != "" ? var.bgp_community : null
  edge_zone           = var.edge_zone != "" ? var.edge_zone : null
  tags                = merge(local.metadata.tags, var.tags)

  // To not cause conflict with azurerm_virtual_network_dns_servers this should never be set
  dns_servers = []

  lifecycle {
    ignore_changes = [
      subnet
    ]
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_virtual_network"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
