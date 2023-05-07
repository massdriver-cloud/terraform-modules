locals {
  azure_identity = {
    location            = var.location
    resource_group_name = var.resource_group_name
    kubernetes = local.is_kubernetes ? {
      namespace            = var.kubernetes.namespace
      service_account_name = var.name
      oidc_issuer_url      = try(var.kubernetes.cluster_artifact.data.infrastructure.oidc_issuer_url, "")
    } : null
  }
}
