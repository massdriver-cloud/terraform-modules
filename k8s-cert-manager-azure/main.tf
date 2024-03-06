module "cert-manager" {
  source             = "../k8s-cert-manager"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  helm_additional_values = {
    podLabels = {
      "azure.workload.identity/use" = "true"
    }
    serviceAccount = {
      labels = {
        "azure.workload.identity/use" = "true"
      }
    }
  }
}
