resource "azurerm_virtual_network_peering" "out" {
  name                      = "peer1to2"
  resource_group_name       = each.value.resource_group_name != "" ? each.value.resource_group_name : var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.this.name
  remote_virtual_network_id = azurerm_virtual_network.example-2.id
}

resource "azurerm_virtual_network_peering" "in" {
  name                      = "peer2to1"
  resource_group_name       = each.value.resource_group_name != "" ? each.value.resource_group_name : var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.example-2.name
  remote_virtual_network_id = azurerm_virtual_network.this.id
}