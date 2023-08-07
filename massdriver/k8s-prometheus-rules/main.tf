locals {
  helm_additional_values = {
    md_metadata  = var.md_metadata
    commonLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "prometheus_rules" {
  name             = "prometheus-rules"
  chart            = "massdriver-prometheus-rules"
  repository       = "https://massdriver-cloud.github.io/helm-charts/"
  version          = "v0.0.1"
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode(local.helm_additional_values),
    yamlencode(var.helm_additional_values)
  ]
}
