module "public_endpoint" {
  count                        = var.endpoint.enabled ? 1 : 0
  source                       = "../../modules-managed-cert/azure/endpoint"
  name                         = var.name
  subnet_id                    = data.azurerm_subnet.default.id
  subdomain                    = var.endpoint.subdomain
  domain                       = "mdazuresbx.com"
  dns_zone_name                = local.zone_name
  dns_zone_resource_group_name = local.zone_resource_group_name
  tags                         = var.tags
  health_check                 = var.health_check
  depends_on = [
    azurerm_resource_group.main
  ]
}
