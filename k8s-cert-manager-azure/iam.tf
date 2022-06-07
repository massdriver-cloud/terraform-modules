locals {
  service_account_name = var.release == "cert-manager" ? "cert-manager" : "${var.release}-cert-manager"
}

data "azurerm_client_config" "current" {
}

## Azure AD application that represents the app
resource "azuread_application" "cert_manager" {
  display_name = "${var.md_metadata.name_prefix}-certmanager"
}

## Azure AD app is required to create the service principal
resource "azuread_service_principal" "cert_manager" {
  application_id = azuread_application.cert_manager.application_id
}

resource "azuread_service_principal_password" "cert_manager" {
  service_principal_id = azuread_service_principal.cert_manager.id
}

resource "azurerm_role_assignment" "cert_manager" {
  for_each             = toset(["Reader", "DNS Zone Contributor"])
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = azuread_service_principal.cert_manager.id
  role_definition_name = each.key
}

resource "kubernetes_secret" "cert_manager" {
  metadata {
    name      = "cert-manager-auth"
    namespace = var.namespace
    labels    = var.md_metadata.default_tags
  }
  data = {
    client-cert = azuread_service_principal_password.cert_manager.value
  }
}
