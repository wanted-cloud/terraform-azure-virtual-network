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

  dynamic "subnet" {
    for_each = { for subnet in var.subnets : subnet.name => subnet }
    content {
      name                                          = subnet.value.name
      address_prefixes                              = subnet.value.address_prefixes
      security_group                                = subnet.value.security_group
      default_outbound_access_enabled               = subnet.value.default_outbound_access_enabled
      private_endpoint_network_policies             = subnet.value.private_endpoint_network_policies
      private_link_service_network_policies_enabled = subnet.value.private_link_service_network_policies_enabled
      route_table_id                                = subnet.value.route_table_id
      service_endpoints                             = subnet.value.service_endpoints
      service_endpoint_policy_ids                   = subnet.value.service_endpoint_policy_ids

      dynamic "delegation" {
        for_each = { for delegation in subnet.value.delegations : delegation.name => delegation }
        content {
          name = delegation.value.name
          service_delegation {
            name    = delegation.value.service_name
            actions = delegation.value.service_actions
          }
        }
      }
    }
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
