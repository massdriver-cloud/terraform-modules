locals {
  zone_name                = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group_name = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

data "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group
}

data "azurerm_subnet" "default" {
  # does it have to be called default?
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_virtual_network.main.resource_group_name
}
