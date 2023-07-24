locals {
  helm_values = {
    md_metadata = var.md_metadata
  }
}

resource "helm_release" "main" {
  name = var.release
  // Use local chart for now, swap to published helm chart when ready
  // chart            = "massdriver-alarm-channel"
  // repository       = "https://massdriver-cloud.github.io/helm-charts/"
  // version          = "v0.1.0"
  chart            = "${path.module}/chart"
  namespace        = var.namespace
  create_namespace = true

  values = [
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
