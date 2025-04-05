resource "azurerm_virtual_network_dns_servers" "this" {
  count              = length(var.dns_servers) > 0 ? 1 : 0
  virtual_network_id = azurerm_virtual_network.this.id
  dns_servers        = var.dns_servers
}