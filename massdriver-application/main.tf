locals {
  # These trys are here so that terraform validate will pass in CI.
  # We dont want to require the user to pass in the path to their MD bundle and requiring
  # everyone to parse the right files and pass them in is error prone. :tada:
  app_specification = try(yamldecode(file("${path.root}/../massdriver.yaml")), {})
  connections       = try(jsondecode(file("${path.root}/_connections.auto.tfvars.json")), {})
  params            = try(jsondecode(file("${path.root}/_params.auto.tfvars.json")), {})
  app_block         = lookup(local.app_specification, "app", {})
  app_envs          = lookup(local.app_block, "envs", {})
  app_policies      = toset(lookup(local.app_block, "policies", []))

  inputs_json = jsonencode({
    params      = local.params
    connections = local.connections
  })

  application_identity_id = var.create_application_identity ? mdxc_application_identity.main.0.id : var.application_identity_id

  policies = { for p in local.app_policies : p => jsondecode(data.jq_query.policies[p].result) }

  base_envs = { for k, v in local.app_envs : k => jsondecode(data.jq_query.envs[k].result) }
  # Needed by Azure k8s until Workload Identity is out of preview.
  azure_envs = (local.is_azure_k8s && mdxc_application_identity.main[0] != null) ? mdxc_application_identity.main[0].azure_application_identity : {}
  azure_aks_envs = local.is_azure && local.is_azure_k8s ? {
    AZURE_TENANT_ID : local.azure_envs.application_id
    AZURE_CLIENT_ID : local.azure_envs.service_principal_client_id
    AZURE_CLIENT_SECRET : local.azure_envs.service_principal_secret
  } : {}

  cloud_envs = {
    azure = merge(local.base_envs, local.azure_aks_envs)
    aws   = local.base_envs
    gcp   = local.base_envs
  }

  envs = local.cloud_envs[data.mdxc_cloud.current.cloud]

  is_aws       = data.mdxc_cloud.current.cloud == "aws"
  is_azure     = data.mdxc_cloud.current.cloud == "azure"
  is_azure_k8s = local.is_azure && local.is_kubernetes
  is_gcp       = data.mdxc_cloud.current.cloud == "gcp"

  is_function   = var.service == "function"
  is_vm         = var.service == "vm"
  is_kubernetes = var.service == "kubernetes"
}

data "jq_query" "policies" {
  for_each = local.app_policies
  data     = local.inputs_json
  query    = each.value
}

data "jq_query" "envs" {
  for_each = local.app_envs
  data     = local.inputs_json
  query    = each.value
}

data "mdxc_cloud" "current" {}

resource "mdxc_application_identity" "main" {
  count = var.create_application_identity ? 1 : 0
  name  = var.name

  gcp_configuration   = local.is_gcp ? local.gcp_identity : null
  azure_configuration = local.is_azure ? local.azure_identity : null
  aws_configuration   = local.is_aws ? local.aws_identity : null
}

resource "mdxc_application_permission" "main" {
  for_each                = local.policies
  application_identity_id = local.application_identity_id
  permission              = each.value
}
