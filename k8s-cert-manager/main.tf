locals {
  # this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "cert-manager" ? "cert-manager" : "${var.release}-cert-manager"

  helm_values = {
    global = {
      leaderElection = {
        namespace = var.namespace
      }
    }
    serviceAccount = {
      name = local.service_account_name
    }
    additionalLabels = var.md_metadata.default_tags
    podLabels        = var.md_metadata.default_tags
  }
}

resource "helm_release" "cert-manager" {
  name             = var.release
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "1.14.3"
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
