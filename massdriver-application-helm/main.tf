locals {
  // Combine environment variables from application and module variables (params)
  combined_envs = merge(
    module.application.envs,
    { for env in var.additional_envs : env.name => env.value }
  )
  base_helm_additional_values = var.chart_repository != null ? {} : {
    commonLabels = module.application.params.md_metadata.default_tags
    pod = {
      annotations = {
        "md-deployment-id" = lookup(module.application.params.md_metadata.deployment, "id", "")
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
  }

  aws_additional_values = merge(local.base_helm_additional_values, {
    serviceAccount = {
      annotations = {
        "eks.amazonaws.com/role-arn" = module.application.id
      }
    }
  })

  gcp_additional_values = merge(local.base_helm_additional_values, {
    serviceAccount = {
      annotations = {
        "iam.gke.io/gcp-service-account" = module.application.id
      }
    }
  })

  # TODO: Add azure, I dont think this has an annotation equiv, will probably be ENV Vars w/ secret
  azure_additional_values = merge(local.base_helm_additional_values, {})

  cloud_specific_helm_additional_values = var.chart_repository != null ? {} : {
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
  version           = var.chart_version
  namespace         = var.namespace
  create_namespace  = true
  force_update      = true
  dependency_update = true

  values = [
    fileexists("${var.chart}/values.yaml") ? file("${var.chart}/values.yaml") : "",
    yamlencode(module.application.params),
    yamlencode(local.helm_additional_values)
  ]
}
