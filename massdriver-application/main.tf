locals {
  root_path         = var.root_path
  app_specification = yamldecode(file("${local.root_path}/../massdriver.yaml"))
  connections       = jsondecode(file("${local.root_path}/_connections.auto.tfvars.json"))
  params            = jsondecode(file("${local.root_path}/_params.auto.tfvars.json"))
  app_block         = lookup(local.app_specification, "app", {})
  app_envs          = lookup(local.app_block, "envs", {})
  app_policies      = toset(lookup(local.app_block, "policies", []))

  inputs_json = jsonencode({
    params      = local.params
    connections = local.connections
  })

  policies = { for p in local.app_policies : p => jsondecode(data.jq_query.policies[p].result) }
  envs     = { for k, v in local.app_envs : k => jsondecode(data.jq_query.envs[k].result) }
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
  name                = var.name
  gcp_configuration   = data.mdxc_cloud.current.cloud == "gcp" ? var.identity : null
  azure_configuration = data.mdxc_cloud.current.cloud == "azure" ? var.identity : null
  aws_configuration   = data.mdxc_cloud.current.cloud == "aws" ? var.identity : null
}

resource "mdxc_application_permission" "main" {
  for_each                = local.policies
  application_identity_id = mdxc_application_identity.main.id
  permission              = each.value
}
