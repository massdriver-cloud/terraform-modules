# TODO: Configure for azure.
# This very well just might be {} since workload identity isnt generally available.

locals {
  azure_identity = local.is_kubernetes ? {
    kubernetes = {
      namespace       = var.kubernetes.namespace
      oidc_issuer_url = var.kubernetes.oidc_issuer_url
    }
  } : {}
}
