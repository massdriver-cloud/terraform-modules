
module "application" {
  # TODO: set the ref to the commit once released.
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=HEAD"
  name    = var.name
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
    cluster_artifact = var.kubernetes_cluster
  }
  resource_group_name = local.azure_resource_group_name
  location            = local.azure_location
}

resource "helm_release" "application" {
  name              = var.name
  chart             = var.chart
  repository        = var.helm_repository
  version           = var.helm_version
  namespace         = var.namespace
  create_namespace  = true
  force_update      = true
  dependency_update = true

  values = [
    fileexists("${var.chart}/values.yaml") ? file("${var.chart}/values.yaml") : "",
    yamlencode(module.application.params),
    yamlencode(module.application.connections),
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
