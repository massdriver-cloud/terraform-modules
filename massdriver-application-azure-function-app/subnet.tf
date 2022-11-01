locals {
  network_name        = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  resource_group_name = regex(".*/resource[g|G]roups/(.*)/providers", var.virtual_network_id)[0]
}

resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.network_name
  address_prefixes     = [var.application.cidr]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "virtual-network-integration"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}