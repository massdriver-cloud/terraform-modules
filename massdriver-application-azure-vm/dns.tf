locals {
  zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

data "azurerm_dns_zone" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  name                = local.zone_name
  resource_group_name = local.zone_resource_group
}

resource "azurerm_dns_cname_record" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  name                = var.dns.subdomain
  zone_name           = data.azurerm_dns_zone.main[0].name
  resource_group_name = data.azurerm_dns_zone.main[0].resource_group_name
  ttl                 = "300"
  record              = "${var.name}.${var.location}.cloudapp.azure.com"
  tags                = var.tags
}
