locals {
  helm_additional_values = {
    commonLabels = var.md_metadata.default_tags
    podLabels    = var.md_metadata.default_tags
  }
}

resource "helm_release" "metrics-server" {
  name             = var.release
  chart            = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  version          = "3.8.1"
  namespace        = var.namespace
  create_namespace = true
  force_update     = true

  values = [
    yamlencode(local.helm_additional_values),
    yamlencode(var.helm_additional_values)
  ]
}
