locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "ingress-nginx" ? "ingress-nginx" : "${var.release}-ingress-nginx"

  # extract data about kubernetes cluster
  cloud            = var.kubernetes_cluster.specs.kubernetes.cloud
  k8s_distribution = var.kubernetes_cluster.specs.kubernetes.distribution

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

resource "helm_release" "ingress-nginx" {
  name             = var.release
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.0.17"
  namespace        = var.namespace
  create_namespace = true
  wait_for_jobs    = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
