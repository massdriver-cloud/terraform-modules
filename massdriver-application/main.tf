locals {
  # These trys are here so that terraform validate will pass in CI.
  # We dont want to require the user to pass in the path to their MD bundle and requiring
  # everyone to parse the right files and pass them in is error prone. :tada:
  app_specification    = try(yamldecode(file("/massdriver/bundle/massdriver.yaml")), {})
  connections          = try(jsondecode(file("${path.root}/_connections.auto.tfvars.json")), {})
  params               = try(jsondecode(file("${path.root}/_params.auto.tfvars.json")), {})
  secrets              = try(jsondecode(file("/massdriver/secrets.json")), {})
  envs                 = try(jsondecode(file("/massdriver/envs.json")), {})
  app_block            = lookup(local.app_specification, "app", {})
  app_policies_queries = toset(lookup(local.app_block, "policies", []))

  application_identity_id = mdxc_application_identity.main.id

  inputs_json = jsonencode({
    params      = local.params
    connections = local.connections
    secrets     = local.secrets
  })

  policies = { for p in local.app_policies_queries : p => jsondecode(data.jq_query.policies[p].result) }

  is_aws   = data.mdxc_cloud.current.cloud == "aws"
  is_azure = data.mdxc_cloud.current.cloud == "azure"
  is_gcp   = data.mdxc_cloud.current.cloud == "gcp"

  is_function   = var.service == "function"
  is_container  = var.service == "container"
  is_vm         = var.service == "vm"
  is_kubernetes = var.service == "kubernetes"
}

data "jq_query" "policies" {
  for_each = local.app_policies_queries
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
