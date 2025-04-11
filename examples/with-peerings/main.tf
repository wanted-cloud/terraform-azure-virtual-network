data "azurerm_virtual_network" "that" {
    name                = "gl-vnet-test-001"
    resource_group_name = "test"
}

module "example" {
    source               = "../.."
    name                 = "example-vnet"
    resource_group_name  = "example-rg"
    address_spaces       = ["10.0.0.0/16"]
    virtual_network_peerings = [{
        name = "example-peering"
        type = "both"
        remote_virtual_network_id = data.azurerm_virtual_network.that.id

    }]
}