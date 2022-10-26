locals {
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.name
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
    cluster_artifact = var.kubernetes_cluster
  }
}


