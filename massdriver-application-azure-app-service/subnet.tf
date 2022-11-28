locals {
  split_id            = split("/", var.virtual_network_id)
  vnet_name           = element(local.split_id, index(local.split_id, "virtualNetworks") + 1)
  vnet_resource_group = element(local.split_id, index(local.split_id, "resourceGroups") + 1)
  cidr                = var.network.auto ? utility_available_cidr.cidr.result : var.network.cidr
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
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group
}

data "azurerm_subnet" "lookup" {
  for_each             = toset(data.azurerm_virtual_network.lookup.subnets)
  name                 = each.key
  virtual_network_name = local.vnet_name
  resource_group_name  = local.vnet_resource_group
}

resource "utility_available_cidr" "cidr" {
  from_cidrs = data.azurerm_virtual_network.lookup.address_space
  used_cidrs = flatten([for subnet in data.azurerm_subnet.lookup : subnet.address_prefixes])
  mask       = 24
}

resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = local.vnet_resource_group
  virtual_network_name = local.vnet_name
  address_prefixes     = [local.cidr]
  service_endpoints    = ["Microsoft.Web"]
  delegation {
    name = "virtual-network-integration"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
