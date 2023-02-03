module "public_endpoint" {
  count                        = var.dns.enable_dns ? 1 : 0
  source                       = "github.com/massdriver-cloud/terraform-modules//azure/endpoint?ref=b4401ac"
  name                         = var.name
  subnet_id                    = azurerm_subnet.main.id
  subdomain                    = var.dns.subdomain
  resource_group_name          = azurerm_resource_group.main.name
  dns_zone_name                = local.zone_name
  dns_zone_resource_group_name = local.zone_resource_group_name
  tags                         = var.tags
  health_check                 = var.health_check
  acme_registration_email_address = var.acme_registration_email_address
  depends_on = [
    azurerm_resource_group.main
  ]
}
