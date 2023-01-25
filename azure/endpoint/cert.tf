module "managed_certificate" {
  source                       = "../../../managed-certificate/azure/managed-certificate"
  name                         = var.name
  resource_group_name          = data.azurerm_resource_group.main.name
  identity                     = azurerm_user_assigned_identity.main
  full_domain                  = local.full_domain
  dns_zone_resource_group_name = var.dns_zone_resource_group_name
}
