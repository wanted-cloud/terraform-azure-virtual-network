output "virtual_network_id" {
  description = "The ID of the virtual network."
  value       = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].id : azurerm_virtual_network.ignored_subnet_management[0].id
}

output "virtual_network_name" {
  description = "The name of the virtual network."
  value       = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].name : azurerm_virtual_network.ignored_subnet_management[0].name
}

output "virtual_network_address_space" {
  description = "The address space of the virtual network."
  value       = var.subnet_management_enabled == true ? azurerm_virtual_network.this[0].address_space : azurerm_virtual_network.ignored_subnet_management[0].address_space
}

output "virtual_network_dns_servers" {
  description = "The DNS servers of the virtual network."
  value       = length(var.dns_servers) > 0 ? azurerm_virtual_network.this[0].dns_servers[0] : null
}

output "virtual_network_private_dns_links" {
  description = "The private DNS zone virtual network links."
  value       = azurerm_private_dns_zone_virtual_network_link.this
}

output "virtual_network_peerings" {
  description = "The virtual network peerings."
  value = merge(
    azurerm_virtual_network_peering.out,
    azurerm_virtual_network_peering.in
  )
}   