locals {
  virtual_network_name                = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  virtual_network_resource_group_name = regex(".*/resource[g|G]roups/(.*)/providers", var.virtual_network_id)[0]
  cidr                                = utility_available_cidr.cidr.result
}

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
  name                 = var.name
  resource_group_name  = local.virtual_network_resource_group_name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = [local.cidr]
  service_endpoints    = ["Microsoft.Web", "Microsoft.Storage"]
  # delegation {
  #   name = "virtual-network-integration"

  #   service_delegation {
  #     name    = "Microsoft.Web/serverFarms"
  #     actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
  #   }
  # }
}
