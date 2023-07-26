locals {
  helm_additional_values = {
    md_metadata  = var.md_metadata
    commonLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "prometheus_rules" {
  name = "prometheus-rules"
  //name = var.release
  // Use local chart for now, swap to published helm chart when ready
  // chart            = "prometheus-rules"
  // repository       = "https://massdriver-cloud.github.io/helm-charts/"
  // version          = "v0.0.1"
  chart            = "${path.module}/prometheus-rules"
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode(local.helm_additional_values),
    yamlencode(var.helm_additional_values)
  ]
}
