module "cert-manager" {
  source             = "../k8s-cert-manager"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  helm_additional_values = {
    serviceAccount = {
      annotations = {
        "iam.gke.io/gcp-service-account" = google_service_account.dns_admin.email
      }
    }
  }
}
