module "public_endpoint" {
  count                               = var.endpoint.enabled ? 1 : 0
  source                              = "../../modules-managed-cert/azure/endpoint"
  name                                = var.name
  subnet_id                           = data.azurerm_subnet.default.id
  subdomain                           = var.endpoint.subdomain
  domain                              = "mdazuresbx.com"
  resource_group_name                 = azurerm_resource_group.main.name
  dns_zone_name                       = local.zone_name
  dns_zone_resource_group_name        = local.zone_resource_group_name
  tags                                = var.tags
  health_check                        = var.health_check
  user_assigned_identity_principal_id = module.application.id
  user_assigned_identity_resource_id  = module.application.identity.azure_application_identity.resource_id
}
