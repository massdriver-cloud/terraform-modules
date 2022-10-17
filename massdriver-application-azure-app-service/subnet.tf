locals {
  split_id            = split("/", var.virtual_network_id)
  network_name        = element(local.split_id, index(local.split_id, "virtualNetworks") + 1)
  resource_group_name = element(local.split_id, index(local.split_id, "resourceGroups") + 1)
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
# Ideally, Massdriver picks an IP range that is not in use
# and is a /24 so we can handle max scale of App Service.
resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.network_name
  address_prefixes     = [var.subnet_cidr]

  delegation {
    name = "virtual-network-integration"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_security_group" "main" {
  name                = var.name
  resource_group_name = azurerm_subnet.main.resource_group_name
  location            = var.application.location
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "main" {
  network_security_group_id = azurerm_network_security_group.main.id
  subnet_id                 = azurerm_subnet.main.id
}
