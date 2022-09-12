locals {
  // Resource names (other than the service accounts) in the helm chart don't support templatization right now
  // so so hardcoding the service account names to match
  controller_service_account_name = "efs-csi-controller"
  node_service_account_name = "efs-csi-node"
  chart_version = "2.2.7"
}

resource "helm_release" "main" {
  name             = var.release
  chart            = "aws-efs-csi-driver"
  repository       = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}