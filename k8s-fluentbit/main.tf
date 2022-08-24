locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = trimprefix(var.release == trimsuffix(var.release, "-fluentbit") ? "${var.release}-fluentbit": var.release, "-")

  # extract data about kubernetes cluster
  cloud            = var.kubernetes_cluster.specs.kubernetes.cloud
  k8s_distribution = var.kubernetes_cluster.specs.kubernetes.distribution

  helm_values = {
    serviceAccount = {
    name = local.service_account_name
    }
    annotations = var.md_metadata.default_tags
  }
}

resource "helm_release" "fluentbit" {
  name             = var.release
  chart            = "fluentbit"
  repository       = "https://fluent.github.io/helm-charts"
  version          = "0.20.6"
  namespace        = var.namespace
  create_namespace = true
  wait_for_jobs    = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
