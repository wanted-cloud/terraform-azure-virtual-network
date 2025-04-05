resource "azurerm_virtual_network_peering" "out" {
  for_each = {
    for peering in var.virtual_network_peerings : peering.name => peering
    if peering.type == "from" || peering.type == "both"
  }
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name != "" ? each.value.resource_group_name : var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.this.name
  remote_virtual_network_id = each.value.remote_virtual_network_id
}

resource "azurerm_virtual_network_peering" "in" {
  for_each = {
    for peering in var.virtual_network_peerings : peering.name => peering
    if peering.type == "to" || peering.type == "both"
  }

  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name != "" ? each.value.resource_group_name : var.resource_group_name
  virtual_network_name      = split("/", each.value.remote_virtual_network_id)[7]
  remote_virtual_network_id = azurerm_virtual_network.this.id
}