variable "name" {
  description = "The name of the virtual network to be provisioned."
  type        = string

  validation {
    error_message = local.metadata.validator_error_messages.virtual_network_name
    condition = can(
      regex(
        local.metadata.validator_expressions.virtual_network_name,
        var.name
      )
    )
  }
}

variable "location" {
  description = "The location/region where the virtual network will be created."
  type        = string
  default     = "North Europe"

  validation {
    error_message = local.metadata.validator_error_messages.allowed_locations
    condition = contains(
      local.metadata.validator_expressions.allowed_locations,
      var.location
    )
  }
}

variable "resource_group_name" {
  description = "The location/region where the virtual network will be created."
  type        = string

  validation {
    error_message = local.metadata.validator_error_messages.resource_group_name
    condition = can(
      regex(
        local.metadata.validator_expressions.resource_group_name,
        var.resource_group_name
      )
    )
  }
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
    link_name             = string
    resource_group_name   = optional(string, "")
    private_dns_zone_name = string
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
    name                      = string
    type                      = string
    resource_group_name       = optional(string, "")
    remote_virtual_network_id = string
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
    subnet_name                                   = string
    address_prefixes                              = list(string)
    default_outbound_access_enabled               = bool
    service_endpoints                             = list(string)
    service_endpoints_policy_ids                  = list(string)
    private_endpoint_network_policies             = string
    private_link_service_network_policies_enabled = bool
    delegations = list(object({
      name            = string
      service_name    = string
      service_actions = list(string)
    }))
  }))
  default = []
}