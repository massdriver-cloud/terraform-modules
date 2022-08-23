locals {
  helm_values = {
    customLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "kube-state-metrics" {
  name             = var.release
  chart            = "kube-state-metrics"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "4.4.3"
  namespace        = var.namespace
  create_namespace = true
  force_update     = true

  values = [
    yamlencode(local.helm_values)
  ]
}
