module "example" {
    source               = "../.."
    name                 = "example-vnet"
    resource_group_name  = "example-rg"
    address_spaces       = ["10.0.0.0/16"]

    subnet_management_enabled = true
    subnets = [{
      name = "example-subnet"
      address_prefixes = ["10.0.0.0/24"]
      service_endpoints = ["Microsoft.Storage"]
      delegations = [{
        name = "example-delegation"
        service_name = "Microsoft.AVS/PrivateClouds"
      }]
    }]
}