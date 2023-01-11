resource "kubernetes_namespace_v1" "main" {
  metadata {
    name   = var.name
    labels = var.labels
  }
}

resource "kubernetes_service_account_v1" "main" {
  metadata {
    name      = "massdriver-cloud-provisioner"
    labels    = var.labels
    namespace = kubernetes_namespace_v1.main.metadata.0.name
  }
}

resource "kubernetes_secret_v1" "main" {
  metadata {
    name      = "massdriver-cloud-provisioner"
    namespace = kubernetes_namespace_v1.main.metadata.0.name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account_v1.main.metadata.0.name
    }
  }
  type = "kubernetes.io/service-account-token"

  # Without this there's a race condition that's harddd to debug
  # I think how it works is that the resource returns and downstream
  # things trying to use the token fail validation. Token can't be xyz...
  wait_for_service_account_token = true
}
