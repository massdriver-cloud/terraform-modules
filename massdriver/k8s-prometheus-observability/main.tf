locals {
  kube_prometheus_stack_values = {
    commonLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name             = var.release
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "v48.1.2"
  namespace        = var.namespace
  create_namespace = true
  wait_for_jobs    = true

  values = [
    "${file("${path.module}/kube_prometheus_stack.yaml")}",
    yamlencode(local.kube_prometheus_stack_values),
    yamlencode(var.kube_prometheus_stack_values)
  ]
}

locals {
  prometheus_rules_values = {
    md_metadata  = var.md_metadata
    commonLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "prometheus_rules" {
  name = var.release
  // Use local chart for now, swap to published helm chart when ready
  // chart            = "prometheus-rules"
  // repository       = "https://massdriver-cloud.github.io/helm-charts/"
  // version          = "v0.0.1"
  chart            = "${path.module}/prometheus-rules"
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode(local.prometheus_rules_values),
    yamlencode(var.prometheus_rules_values)
  ]
}
