locals {
  zone_name                = var.endpoint.enabled ? regex(".*/dns[z|Z]ones/(.*)$", var.endpoint.zone_id)[0] : null
  zone_resource_group_name = var.endpoint.enabled ? regex(".*/resource[g|G]roups/(.*)/providers", var.endpoint.zone_id)[0] : null
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

module "public_endpoint" {
  count                        = var.endpoint.enabled ? 1 : 0
  source                       = "../azure/vm-endpoint"
  name                         = var.md_metadata.name_prefix
  subnet_id                    = data.azurerm_subnet.default.id
  subdomain                    = var.endpoint.subdomain
  domain = "mdazuresbx.com"
  dns_zone_name                = local.zone_name
  dns_zone_resource_group_name = local.zone_resource_group_name
  tags                         = var.md_metadata.default_tags
  resource_group_name          = azurerm_resource_group.main.name
  health_check                 = var.health_check
  depends_on = [
    azurerm_resource_group.main
  ]
}
