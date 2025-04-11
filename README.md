<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-virtual-network

Terraform building block for creation and management of Azure Virtual Network and related resources.

## Table of contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Variables](#inputs)
- [Outputs](#outputs)
- [Resources](#resources)
- [Usage](#usage)
- [Contributing](#contributing)

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>=4.20.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>=4.20.0)

## Required Inputs

The following input variables are required:

### <a name="input_address_spaces"></a> [address\_spaces](#input\_address\_spaces)

Description: The address spaces that will be used by the virtual network.

Type: `list(string)`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the virtual network to be provisioned.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The location/region where the virtual network will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_bgp_community"></a> [bgp\_community](#input\_bgp\_community)

Description: The BGP community associated with the virtual network

Type: `string`

Default: `""`

### <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)

Description: The DNS servers that will be used by the virtual network.

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

### <a name="input_location"></a> [location](#input\_location)

Description: The location/region where the virtual network will be created.

Type: `string`

Default: `""`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Metadata definitions for the module, this is optional construct allowing override of the module defaults defintions of validation expressions, error messages, resource timeouts and default tags.

Type:

```hcl
object({
    resource_timeouts = optional(
      map(
        object({
          create = optional(string, "30m")
          read   = optional(string, "5m")
          update = optional(string, "30m")
          delete = optional(string, "30m")
        })
      ), {}
    )
    tags                     = optional(map(string), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_private_dns_zones"></a> [private\_dns\_zones](#input\_private\_dns\_zones)

Description: The private DNS zones that will be linked to the virtual network.

Type:

```hcl
list(object({
    name                  = string
    resource_group_name   = optional(string, "")
    registration_enabled  = optional(bool, false)
    private_dns_zone_name = string
    tags                  = optional(map(string), {})
  }))
```

Default: `[]`

### <a name="input_subnet_management_enabled"></a> [subnet\_management\_enabled](#input\_subnet\_management\_enabled)

Description: Whether subnet management is enabled within this virtual network module, if false you can use subnet module for IaC management of subnet by achieving state separation.

Type: `bool`

Default: `false`

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

Description: A mapping of tags to assign to the virtual network resource.

Type: `map(string)`

Default: `{}`

### <a name="input_virtual_network_peerings"></a> [virtual\_network\_peerings](#input\_virtual\_network\_peerings)

Description: The virtual network peerings that will be created

Type:

```hcl
list(object({
    name                                   = string
    type                                   = string
    resource_group_name                    = optional(string, "")
    remote_virtual_network_id              = string
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
```

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_virtual_network_address_space"></a> [virtual\_network\_address\_space](#output\_virtual\_network\_address\_space)

Description: The address space of the virtual network.

### <a name="output_virtual_network_dns_servers"></a> [virtual\_network\_dns\_servers](#output\_virtual\_network\_dns\_servers)

Description: The DNS servers of the virtual network.

### <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id)

Description: The ID of the virtual network.

### <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name)

Description: The name of the virtual network.

### <a name="output_virtual_network_peerings"></a> [virtual\_network\_peerings](#output\_virtual\_network\_peerings)

Description: The virtual network peerings.

### <a name="output_virtual_network_private_dns_links"></a> [virtual\_network\_private\_dns\_links](#output\_virtual\_network\_private\_dns\_links)

Description: The private DNS zone virtual network links.

## Resources

The following resources are used by this module:

- [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) (resource)
- [azurerm_virtual_network.ignored_subnet_management](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [azurerm_virtual_network_dns_servers.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) (resource)
- [azurerm_virtual_network_peering.in](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) (resource)
- [azurerm_virtual_network_peering.out](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

## Usage

> For more detailed examples navigate to `examples` folder of this repository.

Module was also published via Terraform Registry and can be used as a module from the registry.

```hcl
module "example" {
  source  = "wanted-cloud/virtual-network/azure"
  version = "x.y.z"
}
```

### Basic usage example

The minimal usage for the module is as follows:

```hcl
module "example" {
    source               = "../.."
    name                 = "example-vnet"
    resource_group_name  = "example-rg"
    address_spaces       = ["10.0.0.0/16"]
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->