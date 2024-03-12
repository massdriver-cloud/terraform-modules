locals {
  service_account_name   = var.release == "cert-manager" ? "cert-manager" : "${var.release}-cert-manager"
  cluster_resource_group = element(split("/", var.kubernetes_cluster.data.infrastructure.ari), index(split("/", var.kubernetes_cluster.data.infrastructure.ari), "resourceGroups") + 1)
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "cert_manager" {
  name = local.cluster_resource_group
}

resource "azurerm_user_assigned_identity" "cert_manager" {
  location            = data.azurerm_resource_group.cert_manager.location
  name                = "${var.md_metadata.name_prefix}-certmanager"
  resource_group_name = local.cluster_resource_group
  tags                = var.md_metadata.default_tags
}

resource "azurerm_federated_identity_credential" "cert_manager" {
  name                = "${var.md_metadata.name_prefix}-certmanager-fc"
  resource_group_name = local.cluster_resource_group
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.kubernetes_cluster.data.infrastructure.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.cert_manager.id
  subject             = "system:serviceaccount:${var.namespace}:${local.service_account_name}"
}

resource "azurerm_role_assignment" "cert_manager" {
  for_each             = toset(["Reader", "DNS Zone Contributor"])
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = azurerm_user_assigned_identity.cert_manager.principal_id
  role_definition_name = each.key
}

resource "kubernetes_secret" "cert_manager" {
  metadata {
    name      = "cert-manager-auth"
    namespace = var.namespace
    labels    = var.md_metadata.default_tags
  }
  data = {
    "azure.json" = jsonencode({
      tenantId                     = data.azurerm_client_config.current.tenant_id
      subscriptionId               = data.azurerm_client_config.current.subscription_id
      resourceGroup                = data.azurerm_resource_group.cert_manager.name
      useWorkloadIdentityExtension = true
    })
  }
}
