module "example" {
    source               = "../.."
    name                 = "example-vnet"
    resource_group_name  = "example-rg"
    address_spaces       = ["10.0.0.0/16"]

    dns_servers = [ "10.200.0.1", "10.200.0.2" ]
}