locals {
  aws_additional_values = merge(local.base_helm_additional_values, {})

  gcp_additional_values = merge(local.base_helm_additional_values, {})

  azure_additional_values = merge(local.base_helm_additional_values, {})

  cloud_specific_helm_additional_values = {
    aws   = local.aws_additional_values,
    gcp   = local.gcp_additional_values,
    azure = local.azure_additional_values
  }

  helm_additional_values = local.cloud_specific_helm_additional_values[module.application.cloud]
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.name
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
    cluster_artifact = var.kubernetes_cluster
  }
}

resource "helm_release" "application" {
  name              = var.name
  chart             = var.chart
  repository        = var.chart_repository
  version           = local.chart_version
  namespace         = var.namespace
  create_namespace  = true
  force_update      = true
  dependency_update = true
  values = [
    fileexists("${path.module}/values.yaml") ? file("${path.module}/values.yaml") : "",
    yamlencode(module.application.params),
    yamlencode(var.helm_values)
  ]
}
