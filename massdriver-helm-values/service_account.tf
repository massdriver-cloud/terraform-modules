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

  # TODO: Azure doesn't support WI yet, so not annotations to add
  azure_service_account = {}

  cloud_service_accounts = {
    aws   = local.aws_service_account,
    gcp   = local.gcp_service_account,
    azure = local.azure_service_account
  }

  service_account = local.cloud_service_accounts[var.massdriver_application.cloud]
}
