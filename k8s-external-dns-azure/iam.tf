locals {
  # This needs to match the SA name in the submodule
  service_account_name = var.release == "external-dns" ? "external-dns" : "${var.release}-external-dns"
  # aks_oidc_short       = replace(var.kubernetes_cluster.data.infrastructure.oidc_issuer_url, "https://", "")
  domain_filters = join(",", tolist(var.azure_dns_zones.dns_zones))
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "external_dns" {
  name = var.azure_dns_zones.resource_group
}

resource "azurerm_user_assigned_identity" "external_dns" {
  location            = data.azurerm_resource_group.external_dns.location
  name                = "${var.md_metadata.name_prefix}-externaldns"
  resource_group_name = data.azurerm_resource_group.external_dns.name
  tags                = var.md_metadata.default_tags
}

resource "azurerm_federated_identity_credential" "external_dns" {
  name                = "${var.md_metadata.name_prefix}-externaldns-fc"
  resource_group_name = data.azurerm_resource_group.external_dns.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.kubernetes_cluster.data.infrastructure.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.external_dns.id
  subject             = "system:serviceaccount:${var.namespace}:${local.service_account_name}"
}

resource "azurerm_role_assignment" "external_dns" {
  for_each             = toset(["Reader", "DNS Zone Contributor"])
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = azurerm_user_assigned_identity.external_dns.principal_id
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
      tenantId                     = data.azurerm_client_config.current.tenant_id
      subscriptionId               = data.azurerm_client_config.current.subscription_id
      resourceGroup                = data.azurerm_resource_group.external_dns.name
      useWorkloadIdentityExtension = true
    })
  }
}
