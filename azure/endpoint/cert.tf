module "managed_certificate" {
  source                        = "github.com/massdriver-cloud/terraform-modules//azure/managed-certificate?ref=bf36471"
  name                          = var.name
  full_domain                   = local.full_domain
  resource_group_name           = data.azurerm_resource_group.main.name
  dns_zone_resource_group_name  = var.dns_zone_resource_group_name
  gateway_identity_principal_id = azurerm_user_assigned_identity.main.principal_id
}
