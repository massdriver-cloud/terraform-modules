locals {
  helm_values = {
    md_metadata = var.md_metadata
  }

  release = coalesce(var.release, var.md_metadata.name_prefix)
}

resource "helm_release" "main" {
  name             = local.release
  chart            = "massdriver-alarm-channel"
  repository       = "https://massdriver-cloud.github.io/helm-charts/"
  version          = "v0.0.1"
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode(local.helm_values),
  ]
}
