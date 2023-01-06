locals {
  zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

data "azurerm_dns_zone" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  name                = local.zone_name
  resource_group_name = local.zone_resource_group
}

resource "azurerm_dns_txt_record" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  name                = "asuid.${var.dns.subdomain}"
  zone_name           = data.azurerm_dns_zone.main[0].name
  resource_group_name = data.azurerm_dns_zone.main[0].resource_group_name
  ttl                 = "300"
  tags                = var.md_metadata.default_tags
  record {
    value = azurerm_linux_function_app.main.custom_domain_verification_id
  }
}

resource "azurerm_dns_cname_record" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  name                = var.dns.subdomain
  zone_name           = data.azurerm_dns_zone.main[0].name
  resource_group_name = data.azurerm_dns_zone.main[0].resource_group_name
  ttl                 = "300"
  record              = azurerm_linux_function_app.main.default_hostname
  tags                = var.md_metadata.default_tags
}


resource "azurerm_app_service_custom_hostname_binding" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  hostname            = join(".", [var.dns.subdomain, azurerm_dns_cname_record.main[0].zone_name])
  app_service_name    = azurerm_linux_function_app.main.name
  resource_group_name = azurerm_resource_group.main.name
  depends_on = [
    azurerm_dns_cname_record.main
  ]
}

resource "azurerm_app_service_managed_certificate" "main" {
  count                      = var.dns.enable_dns ? 1 : 0
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.main[0].id
  tags                       = var.md_metadata.default_tags
  depends_on = [
    azurerm_dns_txt_record.main,
    azurerm_dns_cname_record.main
  ]
}

resource "azurerm_app_service_certificate_binding" "main" {
  count               = var.dns.enable_dns ? 1 : 0
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.main[0].id
  certificate_id      = azurerm_app_service_managed_certificate.main[0].id
  ssl_state           = "SniEnabled"
}
