resource "azurerm_user_assigned_identity" "cert" {
  location            = azurerm_resource_group.main.location
  name                = "${var.name}-cert"
  resource_group_name = azurerm_resource_group.main.name
}

module "managed_certificate" {
  # source                          = "github.com/massdriver-cloud/terraform-modules//azure/managed-certificate?ref=8593752"
  source = "../azure/managed-certificate"
  name                            = var.name
  full_domain                     = "${var.dns.subdomain}.${local.zone_name}"
  resource_group_name        = azurerm_resource_group.main.name
  dns_zone_resource_group_name    = data.azurerm_dns_zone.main.resource_group_name
  gateway_identity_principal_id   = azurerm_user_assigned_identity.cert.principal_id
  acme_registration_email_address = var.acme_registration_email_address
  depends_on = [
    azurerm_resource_group.main
  ]
}

resource "azurerm_container_app_environment_certificate" "example" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  certificate_blob_base64             = module.managed_certificate.cert
  certificate_password         = ""
}
