locals {
  # TODO: think about adding these fields to the infrastructure block so we avoid this
  virtual_network_name                = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  virtual_network_resource_group_name = regex(".*/resource[g|G]roups/(.*)/providers", var.virtual_network_id)[0]
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

resource "utility_available_cidr" "main" {
  from_cidrs = data.azurerm_virtual_network.lookup.address_space
  used_cidrs = flatten([for subnet in data.azurerm_subnet.lookup : subnet.address_prefixes])
  mask       = var.network_mask
}
