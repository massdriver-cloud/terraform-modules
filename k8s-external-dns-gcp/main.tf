locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "external-dns" ? "external-dns" : "${var.release}-external-dns"
}

module "external-dns" {
  source             = "../k8s-external-dns"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  domain_filters     = join(",", concat([for zone, name in var.cloud_dns_managed_zones : name], []))
  helm_additional_values = {
    serviceAccount = {
      annotations = {
        "iam.gke.io/gcp-service-account" = google_service_account.external_dns.email
      }
    }
  }
  dns_provider = "google"
}
