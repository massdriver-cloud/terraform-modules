locals {
  split_id            = split("/", var.virtual_network_id)
  vnet_name           = element(local.split_id, index(local.split_id, "virtualNetworks") + 1)
  vnet_resource_group = element(local.split_id, index(local.split_id, "resourceGroups") + 1)
  cidr                = var.network.auto ? utility_available_cidr.cidr.result : var.network.cidr

  # Keeping this to be implemented if we're able to figure out how to inject it above.
  # regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  # regex(".*/resource[g|G]roups/(.*)/providers", var.virtual_network_id)[0]
}

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
  service_endpoints    = ["Microsoft.Web", "Microsoft.Storage"]
  delegation {
    name = "virtual-network-integration"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
