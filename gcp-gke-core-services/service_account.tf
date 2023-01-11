module "core_services_service_account" {
  source = "../k8s/service-account"
  name   = var.md_metadata.name_prefix
  labels = var.md_metadata.default_tags
}

resource "kubernetes_cluster_role_binding" "cloud_provisioner" {
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
    name      = module.core_services_service_account.service_account.metadata.0.name
    namespace = module.core_services_service_account.namespace.metadata.0.name
  }
}
