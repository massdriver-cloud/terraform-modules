locals {
  // Combine environment variables from application and module variables (params)
  combined_envs = merge(
    module.helm_values.envs,
    { for env in var.additional_envs : env.name => env.value }
  )
  helm_additional_values = {
    commonLabels = module.helm_values.common_labels
    pod = {
      annotations = {
        "md-deployment-id" = module.helm_values.md_deployment_id
      }
    }
    envs = [for key, val in local.combined_envs : { name = key, value = tostring(val) }]
    ingress = {
      className = "nginx" // TODO: eventually this should come from the kubernetes artifact
      annotations = {
        "cert-manager.io/cluster-issuer" : "letsencrypt-prod"     // TODO: eventually this should come from kubernetes artifact
        "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true" // TODO: hardcoding this for now, dependent on nginx
      }
    }
    serviceAccount = module.helm_values.k8s_service_account
  }
}

module "helm_values" {
  source             = "../massdriver-helm-values"
  name               = var.name
  namespace          = var.namespace
  kubernetes_cluster = var.kubernetes_cluster
}

resource "helm_release" "application" {
  name              = var.name
  chart             = var.chart
  repository        = var.chart_repository
  version           = var.chart_version
  namespace         = var.namespace
  create_namespace  = true
  force_update      = true
  dependency_update = true

  values = [
    fileexists("${var.chart}/values.yaml") ? file("${var.chart}/values.yaml") : "",
    yamlencode(module.helm_values.application.params),
    yamlencode(local.helm_additional_values)
  ]
}
