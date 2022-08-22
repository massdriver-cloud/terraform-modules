# For GCP individual service receive a service_account email to bind what they run as, so we don't need to do anything
# in the non-GKE scenario, for GKE, we need to build a workload identity. MDXC has all of the data it needs besides the 

# TODO: Set the below fields
locals {
  gcp_identity = var.service == "kubernetes" ? {
    namespace       = "TODO"
    service_account = "TODO"
  } : {}
}
