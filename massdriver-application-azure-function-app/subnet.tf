locals {
  split_id            = split("/", var.virtual_network_id)
  network_name        = element(local.split_id, index(local.split_id, "virtualNetworks") + 1)
  resource_group_name = element(local.split_id, index(local.split_id, "resourceGroups") + 1)
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