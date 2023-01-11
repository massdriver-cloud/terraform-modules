locals {
  virtual_network_name = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  cidr                 = var.enable_auto_cidr ? module.auto_cidr[0].cidr : var.cidr
}

data "azurerm_resource_group" "virtual_network" {
  name = local.virtual_network_name
}

# you can't add a subnet from one resource group to another
# okay okay, we can work with that
# resource "azurerm_resource_group" "main" {
#   name     = var.md_metadata.name_prefix
#   location = var.region
#   tags     = var.md_metadata.default_tags
# }

resource "azurerm_subnet" "main" {
  name                 = var.md_metadata.name_prefix
  resource_group_name  = data.azurerm_resource_group.virtual_network.name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = [cidrsubnet(module.auto_cidr[0].cidr, 1, 0)]
  # how many and which ones? what happens if we remove this completely
  service_endpoints = ["Microsoft.Storage"]

  delegation {
    name = "delegation"
    # These are specific to the service, what....
    # Found a great resource for live-code and modules. Check it out here
    # https://github.com/claranet/terraform-azurerm-subnet/blob/master/examples/main/modules.tf#L68
    # check the service delegation block here
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
