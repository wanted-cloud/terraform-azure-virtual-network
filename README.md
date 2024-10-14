<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-virtual-network

Terraform building block for creation and management of Azure Virtual Network and related resources.

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>=3.113.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>=3.113.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) (resource)
- [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_virtual_network_dns_servers.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) (resource)
- [azurerm_virtual_network_peering.in](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) (resource)
- [azurerm_virtual_network_peering.out](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces)

Description: The address spaces that will be used by the virtual network

Type: `list(string)`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The location/region where the virtual network will be created

Type: `string`

### <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name)

Description: The name of the virtual network

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community)

Description: The BGP community associated with the virtual network

Type: `string`

Default: `""`

### <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)

Description: The DNS servers that will be used by the virtual network

Type: `list(string)`

Default: `[]`

### <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone)

Description: The edge zone associated with the virtual network

Type: `string`

Default: `""`

### <a name="input_flow_timeout_in_minutes"></a> [flow\_timeout\_in\_minutes](#input\_flow\_timeout\_in\_minutes)

Description: The flow timeout in minutes

Type: `number`

Default: `30`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Module metadata object to give user possibility to override default module values.

Type:

```hcl
object({
    default_tags             = optional(map(string), {})
    resource_timeouts        = optional(map(map(string)), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones)

Description: The private DNS zones that will be linked to the virtual network

Type:

```hcl
list(object({
    link_name             = string
    resource_group_name   = optional(string, "")
    private_dns_zone_name = string
  }))
```

Default: `[]`

### <a name="input_subnets"></a> [subnets](#input\_subnets)

Description: List of subnets to be created in the virtual network

Type:

```hcl
list(object({
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
```

Default: `[]`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Key value pairs of custom tags to be applied to the module resources.

Type: `map(string)`

Default: `{}`

### <a name="input_virtual_network_peerings"></a> [virtual\_network\_peerings](#input\_virtual\_network\_peerings)

Description: The virtual network peerings that will be created

Type:

```hcl
list(object({
    name                      = string
    type                      = string
    resource_group_name       = optional(string, "")
    remote_virtual_network_id = string
  }))
```

Default: `[]`

## Outputs

No outputs.

Created by WANTED.solutions s.r.o.
---
<sup><sub>_2024 &copy; All rights reserved - WANTED.solutions s.r.o. [<@wanted-solutions>](https://github.com/wanted-solutions)_</sub></sup>
<!-- END_TF_DOCS -->