locals {
  virtual_network_name                = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  virtual_network_resource_group_name = regex(".*/resource[g|G]roups/(.*)/providers", var.virtual_network_id)[0]
  cidr                                = var.network.auto ? utility_available_cidr.cidr.result : var.network.cidr
}

# This subnet is for the IPs of the Azure App Service instances.
# For App Service instances to be able to access things in the VNet,
# we create this subnet and make use of "Virtual network integration".
#
# "Virtual network integration depends on a dedicated subnet.
# When you create a subnet, the Azure subnet loses five IPs
# from the start. One address is used from the integration
# subnet for each plan instance. If you scale your app to four
# instances, then four addresses are used.""
#
# The max scale for Azure App Service
# Default: 10
# Isolated tier (max?): 100
# So we need 105
# But when scaling, max is doubled.... so 210
# CIDR minus 5, halved and floored
# /28 16 - 5 = 11 => 5
# /27 32 - 5 = 27 => 13
# /26 64 - 5 = 59 => 29
# /25 128 - 5 = 123 => 61
# /24 256 - 5 = 251 => 125
#
# Ideally, Massdriver picks an IP range that is not in use
# and is a /24 so we can handle max scale of App Service.
# For now, we require the user to provide a /24.

data "azurerm_virtual_network" "lookup" {
  name                = local.virtual_network_name
  resource_group_name = local.virtual_network_resource_group_name
}

data "azurerm_subnet" "lookup" {
  for_each             = toset(data.azurerm_virtual_network.lookup.subnets)
  name                 = each.key
  virtual_network_name = local.virtual_network_name
  resource_group_name  = local.virtual_network_resource_group_name
}

resource "utility_available_cidr" "cidr" {
  from_cidrs = data.azurerm_virtual_network.lookup.address_space
  used_cidrs = flatten([for subnet in data.azurerm_subnet.lookup : subnet.address_prefixes])
  mask       = 24
}

resource "azurerm_subnet" "main" {
  name                 = var.md_metadata.name_prefix
  resource_group_name  = local.virtual_network_resource_group_name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = [local.cidr]
  service_endpoints    = ["Microsoft.Web", "Microsoft.Storage"]
  delegation {
    name = "virtual-network-integration"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
