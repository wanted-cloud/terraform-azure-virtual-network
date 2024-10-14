locals {
  // This definition must remain here to keep module metadata working
  module_metadata = {}
  // Here you can add your own local definitions
  local_peerings = [
    for peering in var.virtual_network_peerings : peering if peering.type != "global"
  ]
  global_peerings = [
    for peering in var.virtual_network_peerings : peering if peering.type == "global"
  ]
}