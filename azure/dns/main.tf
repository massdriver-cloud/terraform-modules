locals {
  which_one = var.azurerm_linux_function_app != null ? var.azurerm_linux_function_app : var.azurerm_linux_web_app
}

data "azurerm_dns_zone" "main" {
  name                = var.zone_name
  resource_group_name = var.zone_resource_group_name
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_dns_txt_record" "main" {
  name                = "asuid.${var.subdomain}"
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  ttl                 = "300"
  tags                = var.tags
  record {
    value = local.which_one.custom_domain_verification_id
  }
}

resource "azurerm_dns_cname_record" "main" {
  name                = var.subdomain
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  ttl                 = "300"
  record              = local.which_one.default_hostname
  tags                = var.tags
}

resource "azurerm_app_service_custom_hostname_binding" "main" {
  hostname            = join(".", [var.subdomain, azurerm_dns_cname_record.main.zone_name])
  app_service_name    = local.which_one.name
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_app_service_managed_certificate" "main" {
  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.main.id
  # there's a bug with this resource.
  # on _every_ plan, TF says tags need to be added
  # https://github.com/hashicorp/terraform-provider-azurerm/issues/11816
  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_app_service_certificate_binding" "main" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.main.id
  certificate_id      = azurerm_app_service_managed_certificate.main.id
  ssl_state           = "SniEnabled"
}
