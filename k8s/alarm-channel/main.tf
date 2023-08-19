locals {
  helm_values = {
    md_metadata = var.md_metadata
  }

  // if a release is passed, use it. Otherwise use the name_prefix with "-alarm-channel" suffix to prevent collisions
  // since there is likely another release (the application itself) using the name_prefix as the release
  release = coalesce(var.release, "${var.md_metadata.name_prefix}-alarm-channel")
}

resource "helm_release" "main" {
  name             = local.release
  chart            = "massdriver-alarm-channel"
  repository       = "https://massdriver-cloud.github.io/helm-charts/"
  version          = "v0.0.2"
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode(local.helm_values),
  ]
}
