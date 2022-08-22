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
  name = var.name
  # TODO: GCP - for k8s it'll look like assume role in aws , we pass some args to mdoule.application
  # for non-k8s, all services use a SA JSON file, so we'll need to actually inject _that_ into ENV vars so that they can be handed off to the runtime (helm, cloudfunctions, etc)
  # these values should be in gcp_output or whatever from mdxc_application_identity
  # gcp_configuration = {kubernetes = {namespace = "foo"}}  
  gcp_configuration = data.mdxc_cloud.current.cloud == "gcp" ? null : null
  # TODO: Azure
  azure_configuration = data.mdxc_cloud.current.cloud == "azure" ? null : null
  aws_configuration   = data.mdxc_cloud.current.cloud == "aws" ? local.aws_identity : null

}

resource "mdxc_application_permission" "main" {
  for_each                = local.policies
  application_identity_id = mdxc_application_identity.main.id
  permission              = each.value
}


