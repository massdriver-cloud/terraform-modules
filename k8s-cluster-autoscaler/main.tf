locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "${local.cloud}-cluster-autoscaler" ? "${local.cloud}-cluster-autoscaler" : "${var.release}-cluster-autoscaler"
  cloud                = var.kubernetes_cluster.specs.kubernetes.cloud

  helm_values = {
    cloudProvider = local.cloud
    rbac = {
      serviceAccount = {
        name = local.service_account_name
      }
    }
    additionalLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "cluster-autoscaler" {
  name             = var.release
  chart            = "cluster-autoscaler"
  repository       = "https://kubernetes.github.io/autoscaler"
  version          = "9.29.2"
  namespace        = var.namespace
  create_namespace = true
  force_update     = true

  values = [
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values),
  ]
}
