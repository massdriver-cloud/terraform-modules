locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "fluentbit" ? "fluentbit" : "${var.release}-fluentbit"

  # extract data about kubernetes cluster
  cloud            = var.kubernetes_cluster.specs.kubernetes.cloud
  k8s_distribution = var.kubernetes_cluster.specs.kubernetes.distribution

  helm_values = {
    serviceAccount = {
      name = local.service_account_name
    }
    labels = var.md_metadata.default_tags
  }
}

resource "helm_release" "fluentbit" {
  name             = var.release
  chart            = "fluent-bit"
  repository       = "https://fluent.github.io/helm-charts"
  version          = "v0.20.6"
  namespace        = var.namespace
  create_namespace = true
  wait_for_jobs    = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
