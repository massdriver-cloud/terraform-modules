# For GCP individual service receive a service_account email to bind what they run as, so we don't need to do anything
# in the non-GKE scenario, for GKE, we need to build a workload identity. MDXC has all of the data it needs besides the
# namespace and k8s service account name

locals {
  gcp_identity = local.is_gcp && local.is_kubernetes ? {
    kubernetes = {
      namespace            = var.kubernetes.namespace
      service_account_name = var.name
    }
  } : {}
}
