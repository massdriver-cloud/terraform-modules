locals {
  # These trys are here so that terraform validate will pass in CI.
  # We dont want to require the user to pass in the path to their MD bundle and requiring
  # everyone to parse the right files and pass them in is error prone. :tada:
  app_specification    = try(yamldecode(file("${path.root}/../massdriver.yaml")), {})
  connections          = try(jsondecode(file("${path.root}/_connections.auto.tfvars.json")), {})
  params               = try(jsondecode(file("${path.root}/_params.auto.tfvars.json")), {})
  secrets              = try(jsondecode(file("${path.root}/../secrets.json")), {})
  app_block            = lookup(local.app_specification, "app", {})
  app_envs_queries     = lookup(local.app_block, "envs", {})
  app_policies_queries = toset(lookup(local.app_block, "policies", []))

  # package input fields to be exposed to JQ queries
  inputs_json = jsonencode({
    params      = local.params
    connections = local.connections
    secrets     = local.secrets
  })

  application_identity_id = mdxc_application_identity.main.id

  policies = { for p in local.app_policies_queries : p => jsondecode(data.jq_query.policies[p].result) }

  # env vars that have been resolved. additional vars may be added per cloud
  base_envs = { for k, v in local.app_envs_queries : k => jsondecode(data.jq_query.envs[k].result) }

  # Auto generate ENV Vars for each secret
  envs_with_secrets = merge(local.base_envs, local.secrets)

  # App Serivce / Function App will auto-inject the secret, but still need these env-vars added.
  # AKS auto-injects everything (we add the Client ID and Tenant ID as annotations).
  azure_envs = local.is_azure && mdxc_application_identity.main.azure_application_identity != null ? {
    AZURE_CLIENT_ID = try(mdxc_application_identity.main.azure_application_identity.client_id, "")
    AZURE_TENANT_ID = try(mdxc_application_identity.main.azure_application_identity.tenant_id, "")
  } : {}

  cloud_envs = {
    azure = merge(local.azure_envs, local.envs_with_secrets)
    aws   = local.envs_with_secrets
    gcp   = local.envs_with_secrets
  }

  envs = local.cloud_envs[data.mdxc_cloud.current.cloud]

  is_aws   = data.mdxc_cloud.current.cloud == "aws"
  is_azure = data.mdxc_cloud.current.cloud == "azure"
  is_gcp   = data.mdxc_cloud.current.cloud == "gcp"

  is_function   = var.service == "function"
  is_vm         = var.service == "vm"
  is_kubernetes = var.service == "kubernetes"
}

data "jq_query" "policies" {
  for_each = local.app_policies_queries
  data     = local.inputs_json
  query    = each.value
}

data "jq_query" "envs" {
  for_each = local.app_envs_queries
  data     = local.inputs_json
  query    = each.value
}

data "mdxc_cloud" "current" {}

resource "mdxc_application_identity" "main" {
  name = var.name

  gcp_configuration   = local.is_gcp ? local.gcp_identity : null
  azure_configuration = local.is_azure ? local.azure_identity : null
  aws_configuration   = local.is_aws ? local.aws_identity : null
}

resource "mdxc_application_permission" "main" {
  for_each                = local.policies
  application_identity_id = local.application_identity_id
  permission              = each.value
}
