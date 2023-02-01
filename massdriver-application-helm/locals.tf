locals {
  is_aks = module.application.cloud == "azure" && var.kubernetes_cluster.specs.kubernetes.distribution == "aks"
  is_eks = module.application.cloud == "aws" && var.kubernetes_cluster.specs.kubernetes.distribution == "eks"
  is_gke = module.application.cloud == "gcp" && var.kubernetes_cluster.specs.kubernetes.distribution == "gke"

  // For other Azure runtimes (App Service, Function App, etc) we make a separate resource group for the application.
  // For AKS, we use the AKS cluster resource group and location since the identity is associated to the AKS OIDC identity.
  azure_resource_group_name = local.is_aks ? element(split("/", var.kubernetes_cluster.data.infrastructure.ari), index(split("/", var.kubernetes_cluster.data.infrastructure.ari), "resourceGroups") + 1) : null
  azure_location            = local.is_aks ? var.kubernetes_cluster.specs.azure.region : null

  // Each cloud needs service account annotations in order for the application identity to be properly assumed
  aws_service_account = {
    annotations = {
      "eks.amazonaws.com/role-arn" = module.application.id
    }
  }
  gcp_service_account = {
    annotations = {
      "iam.gke.io/gcp-service-account" = module.application.id
    }
  }
  azure_service_account = {
    labels = {
      "azure.workload.identity/use" = "true"
    }
    annotations = {
      "azure.workload.identity/client-id" = try(module.application.identity.azure_application_identity.client_id, "")
      "azure.workload.identity/tenant-id" = try(module.application.identity.azure_application_identity.tenant_id, "")
    }
  }

  cloud_service_accounts = {
    aws   = local.aws_service_account,
    gcp   = local.gcp_service_account,
    azure = local.azure_service_account
  }

  // Combine environment variables from application and module variables (params)
  combined_envs = merge(
    module.application.envs,
    { for env in var.additional_envs : env.name => env.value }
  )
}
