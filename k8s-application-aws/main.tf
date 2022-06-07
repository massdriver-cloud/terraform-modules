
resource "helm_release" "application" {
  name             = var.md_metadata.name_prefix
  chart            = local.helm_chart
  repository       = local.helm_repository
  namespace        = var.namespace
  create_namespace = true
  force_update     = true

  values = [
    yamlencode(local.params),
    yamlencode(local.helm_additional_values)
  ]
}
