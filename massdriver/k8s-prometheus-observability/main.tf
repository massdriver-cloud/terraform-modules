locals {
  helm_additional_values = {
    commonLabels = var.md_metadata.default_tags
    grafana = {
      extraLabels = var.md_metadata.default_tags
    }
    kube-state-metrics = {
      customLabels = var.md_metadata.default_tags
    }
    prometheus-node-exporter = {
      podLabels = var.md_metadata.default_tags
    }
    prometheus = {
      prometheusSpec = {
        podMetadata = {
          labels = var.md_metadata.default_tags
        }
      }
    }
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
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_additional_values),
    yamlencode(var.helm_additional_values)
  ]
}
