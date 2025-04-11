variable "name" {
  description = "The name of the virtual network to be provisioned."
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network will be created."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "The location/region where the virtual network will be created."
  type        = string

}

variable "address_spaces" {
  description = "The address spaces that will be used by the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "The DNS servers that will be used by the virtual network."
  type        = list(string)
  default     = []
}

variable "private_dns_zones" {
  description = "The private DNS zones that will be linked to the virtual network."
  type = list(object({
    name                  = string
    resource_group_name   = optional(string, "")
    registration_enabled  = optional(bool, false)
    private_dns_zone_name = string
    tags                  = optional(map(string), {})
  }))
  default = []
}

variable "bgp_community" {
  description = "The BGP community associated with the virtual network"
  type        = string
  default     = ""
}

variable "edge_zone" {
  description = "The edge zone associated with the virtual network"
  type        = string
  default     = ""
}

variable "flow_timeout_in_minutes" {
  description = "The flow timeout in minutes"
  type        = number
  default     = 30
}

variable "virtual_network_peerings" {
  description = "The virtual network peerings that will be created"
  type = list(object({
    name                                   = string
    remote_virtual_network_id              = string
    resource_group_name                    = optional(string, "")
    type                                   = optional(string, "both")
    allow_virtual_network_access           = optional(bool, true)
    allow_forwarded_traffic                = optional(bool, true)
    allow_gateway_transit                  = optional(bool, false)
    use_remote_gateways                    = optional(bool, false)
    local_subnet_names                     = optional(list(string), [])
    remote_subnet_names                    = optional(list(string), [])
    only_ipv6_peering_enabled              = optional(bool, false)
    peer_complete_virtual_networks_enabled = optional(bool, true)
    triggers                               = optional(map(string), {})
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the virtual network resource."
  type        = map(string)
  default     = {}
}


variable "subnet_management_enabled" {
  description = "Whether subnet management is enabled within this virtual network module, if false you can use subnet module for IaC management of subnet by achieving state separation."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "List of subnets to be created in the virtual network"
  type = list(object({
    name                                          = string
    address_prefixes                              = list(string)
    security_group                                = optional(string, null)
    default_outbound_access_enabled               = optional(bool, true)
    private_endpoint_network_policies             = optional(string, "Disabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    route_table_id                                = optional(string, null)
    service_endpoints                             = optional(list(string), [])
    service_endpoint_policy_ids                   = optional(list(string), [])

    delegations = optional(list(object({
      name            = string
      service_name    = string
      service_actions = optional(list(string), [])
    })), [])
  }))
  default = []
}