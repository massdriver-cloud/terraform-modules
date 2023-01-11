locals {
  aws_service_account = {
    annotations = {
      "eks.amazonaws.com/role-arn" = var.massdriver_application.id
    }
  }

  gcp_service_account = {
    annotations = {
      "iam.gke.io/gcp-service-account" = var.massdriver_application.id
    }
  }

  # https://learn.microsoft.com/en-us/azure/aks/workload-identity-overview#service-account-labels-and-annotations
  azure_service_account = {
    labels = {
      "azure.workload.identity/use" = true
    }
    annotations = {
      # https://learn.microsoft.com/en-us/azure/aks/learn/tutorial-kubernetes-workload-identity#create-kubernetes-service-account
      "azure.workload.identity/client-id" = var.massdriver_application.envs["USER_ASSIGNED_CLIENT_ID"]
      # optional, not sure what the pros and cons are
      # "azure.workload.identity/tenant-id" = ""
    }
  }

  cloud_service_accounts = {
    aws   = local.aws_service_account,
    gcp   = local.gcp_service_account,
    azure = local.azure_service_account
  }

  service_account = local.cloud_service_accounts[var.massdriver_application.cloud]
}
