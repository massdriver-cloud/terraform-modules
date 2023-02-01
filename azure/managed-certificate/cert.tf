data "azuread_client_config" "current" {}

resource "azuread_application" "external_dns" {
  display_name = "${var.name}-externaldns"
  owners       = [data.azuread_client_config.current.object_id]
}

# A Service Principal? Why not a Managed Identity?
# Good question! Here, we need to create a "classic" Service Principal
# So that ACME can create a TXT record in the target DNS zone to verify
# the domain and create an SSL certificate.
# ACME lives outside of Azure,
# things that access Azure from outside the cloud use a Service Principal
# and explicitly can't use a Managed Identity.
#
# I think this changes in AKS though. The request to modify the DNS record
# would be coming from the AKS pod. That pod can use a Managed Identity,
# or in the case of AKS, it would use a Managed Indetity via "workload identity".
resource "azuread_service_principal" "external_dns" {
  application_id = azuread_application.external_dns.application_id
  owners         = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "external_dns" {
  service_principal_id = azuread_service_principal.external_dns.id
}

resource "azurerm_role_assignment" "cert_manager" {
  for_each             = toset(["Reader", "DNS Zone Contributor"])
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = azuread_service_principal.external_dns.id
  role_definition_name = each.key
}

# Creates a private key in PEM format
resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "acme_registration" "main" {
  account_key_pem = tls_private_key.main.private_key_pem
  email_address   = var.acme_registration_email_address
}

resource "acme_certificate" "main" {
  account_key_pem = acme_registration.main.account_key_pem
  common_name     = var.full_domain

  # https://registry.terraform.io/providers/getstackhead/acme/latest/docs/guides/dns-providers-azure
  dns_challenge {
    provider = "azure"

    config = {
      AZURE_CLIENT_ID       = azuread_service_principal.external_dns.application_id
      AZURE_TENANT_ID       = azuread_service_principal.external_dns.application_tenant_id
      AZURE_CLIENT_SECRET   = azuread_service_principal_password.external_dns.value
      AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
      AZURE_ENVIRONMENT     = "public"
      AZURE_RESOURCE_GROUP  = var.dns_zone_resource_group_name
    }
  }

  depends_on = [
    acme_registration.main,
    azurerm_key_vault_access_policy.terraform,
    azurerm_key_vault_access_policy.service
  ]
}

# https://learn.microsoft.com/en-us/azure/api-management/configure-custom-domain?tabs=key-vault#domain-certificate-options
resource "azurerm_key_vault_certificate" "main" {
  name         = var.name
  key_vault_id = azurerm_key_vault.main.id

  certificate {
    contents = acme_certificate.main.certificate_p12
  }

  depends_on = [
    azurerm_key_vault_access_policy.terraform,
    azurerm_key_vault_access_policy.service
  ]
}
