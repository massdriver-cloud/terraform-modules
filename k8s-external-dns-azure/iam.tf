locals {
  # This needs to match the SA name in the submodule
  service_account_name = var.release == "external-dns" ? "external-dns" : "${var.release}-external-dns"
  domain_filters       = join(",", tolist(var.azure_dns_zones.dns_zones))
}

data "azurerm_client_config" "current" {
}

## Azure AD application that represents the app
resource "azuread_application" "external_dns" {
  display_name = "${var.md_metadata.name_prefix}-externaldns"
}

## Azure AD app is required to create the service principal
resource "azuread_service_principal" "external_dns" {
  application_id = azuread_application.external_dns.application_id
}

resource "azuread_service_principal_password" "external_dns" {
  service_principal_id = azuread_service_principal.external_dns.id
}

resource "azurerm_role_assignment" "external_dns" {
  for_each             = toset(["Reader", "DNS Zone Contributor"])
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = azuread_service_principal.external_dns.id
  role_definition_name = each.key
}

resource "kubernetes_secret" "external_dns" {
  metadata {
    name      = "external-dns-auth"
    namespace = var.namespace
    labels    = var.md_metadata.default_tags
  }
  data = {
    "azure.json" = jsonencode({
      tenantId        = data.azurerm_client_config.current.tenant_id
      subscriptionId  = data.azurerm_client_config.current.subscription_id
      resourceGroup   = var.azure_dns_zones.resource_group
      aadClientId     = azuread_service_principal.external_dns.application_id
      aadClientSecret = azuread_service_principal_password.external_dns.value
    })
  }
}
