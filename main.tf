/**
 * # wanted-cloud/terraform-azure-virtual-network
 *
 * Terraform building block for creation and management of Azure Virtual Network and related resources.
 *
 */
resource "azurerm_virtual_network" "this" {
  count               = var.subnet_management_enabled == true ? 1 : 0
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.address_spaces
  // To not cause conflict with azurerm_virtual_network_dns_servers this should never be set
  dns_servers = []

  bgp_community = var.bgp_community != "" ? var.bgp_community : null
  edge_zone     = var.edge_zone != "" ? var.edge_zone : null

  tags = local.metadata.tags

}

resource "azurerm_virtual_network" "this" {
  count               = var.subnet_management_enabled == true ? 0 : 1
  name                = var.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  address_space       = var.address_spaces
  // To not cause conflict with azurerm_virtual_network_dns_servers this should never be set
  dns_servers = []

  bgp_community = var.bgp_community != "" ? var.bgp_community : null
  edge_zone     = var.edge_zone != "" ? var.edge_zone : null

  tags = local.metadata.tags

  lifecycle {
    ignore_changes = [
      subnet
    ]
  }
}
