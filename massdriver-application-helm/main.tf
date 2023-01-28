locals {
  // Combine environment variables from application and module variables (params)
  combined_envs = merge(
    module.application.envs,
    { for env in var.additional_envs : env.name => env.value }
  )
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=4270f29"
  name    = var.name
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
    cluster_artifact = var.kubernetes_cluster
  }

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "helm_release" "application" {
  name              = var.name
  chart             = var.chart
  namespace         = var.namespace
  create_namespace  = true
  force_update      = true
  dependency_update = true

  values = [
    fileexists("${var.chart}/values.yaml") ? file("${var.chart}/values.yaml") : "",
    yamlencode(module.application.params),
    yamlencode(var.helm_additional_values),
    yamlencode(local.helm_values)
  ]
}
