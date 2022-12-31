resource "kubernetes_service_account_v1" "cloud_provisioner" {
  metadata {
    name   = "massdriver-cloud-provisioner"
    labels = var.md_metadata.default_tags
  }
}

resource "kubernetes_secret_v1" "main" {
  metadata {
    name = "massdriver-cloud-provisioner"
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account_v1.cloud_provisioner.metadata.0.name
    }
  }
  type = "kubernetes.io/service-account-token"
}

resource "kubernetes_cluster_role_binding" "massdriver-cloud-provisioner" {
  metadata {
    name   = "massdriver-cloud-provisioner"
    labels = var.md_metadata.default_tags
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.cloud_provisioner.metadata.0.name
    namespace = kubernetes_service_account_v1.cloud_provisioner.metadata.0.namespace
  }
}
