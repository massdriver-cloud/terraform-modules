data "azurerm_dns_zone" "main" {
  for_each            = var.dns.enable_dns ? toset(["enabled"]) : toset([])
  name                = var.dns.zone_name
  resource_group_name = var.dns.zone_resource_group
}

resource "azurerm_dns_txt_record" "main" {
  for_each            = var.dns.enable_dns ? toset(["enabled"]) : toset([])
  name                = "${var.dns.txt_record}.${var.dns.zone_name}"
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  ttl                 = "300"
  record {
    value = azurerm_linux_web_app.main.custom_domain_verification_id
  }
}

resource "azurerm_dns_cname_record" "main" {
  for_each            = var.dns.enable_dns ? toset(["enabled"]) : toset([])
  name                = var.dns.cname_record
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  ttl                 = "300"
  record              = azurerm_linux_web_app.main.default_hostname
}


resource "azurerm_app_service_custom_hostname_binding" "main" {
  for_each            = var.dns.enable_dns ? toset(["enabled"]) : toset([])
  hostname            = join(".", [azurerm_dns_cname_record.main.name, azurerm_dns_cname_record.main.zone_name])
  app_service_name    = azurerm_linux_web_app.main.name
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_app_service_managed_certificate" "main" {
  for_each                   = var.dns.enable_dns ? toset(["enabled"]) : toset([])
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.main.id
}

resource "azurerm_app_service_certificate_binding" "main" {
  for_each            = var.dns.enable_dns ? toset(["enabled"]) : toset([])
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.main.id
  certificate_id      = azurerm_app_service_managed_certificate.main.id
  ssl_state           = "SniEnabled"
}
