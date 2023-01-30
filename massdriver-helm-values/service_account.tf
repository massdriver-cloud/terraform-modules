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

  azure_service_account = {
    labels = {
      "azure.workload.identity/use" = "true"
    }
    annotations = {
      "azure.workload.identity/client-id" = var.massdriver_application.identity.azure_application_identity.client_id
      "azure.workload.identity/tenant-id" = var.massdriver_application.identity.azure_application_identity.tenant_id
    }
  }

  cloud_service_accounts = {
    aws   = local.aws_service_account,
    gcp   = local.gcp_service_account,
    azure = local.azure_service_account
  }

  service_account = local.cloud_service_accounts[var.massdriver_application.cloud]
}
