locals {
  app_envs = lookup(local.app_block, "envs", {})

  // extract flattened list of all environmetn variables, while mutating to append dependency (connection) name to front of path
  merged_envs_connections = flatten([for env_key, env_path in local.app_envs : [
    split(".", env_path)[0] == "connections" ? [{ name = env_key, value = ".${join(".", slice(split(".", env_path), 1, length(split(".", env_path))))}" }] : []
  ]])
  mapped_envs_connections = { for env in local.merged_envs_connections : env.name => env.value }
  result_envs_connections = [for name, value in local.mapped_envs_connections : { name = name, value = tostring(jsondecode(data.jq_query.envs_connections["${name}"].result)) }]

  merged_envs_params = flatten([for env_key, env_path in local.app_envs : [
    split(".", env_path)[0] == "params" ? [{ name = env_key, value = ".${join(".", slice(split(".", env_path), 1, length(split(".", env_path))))}" }] : []
  ]])
  mapped_envs_params = { for env in local.merged_envs_params : env.name => env.value }
  result_envs_params = [for name, value in local.mapped_envs_params : { name = name, value = tostring(jsondecode(data.jq_query.envs_params["${name}"].result)) }]
  result_envs        = concat(local.result_envs_connections, local.result_envs_params)
}

data "jq_query" "envs_connections" {
  for_each = local.mapped_envs_connections
  data     = jsonencode(local.connections)
  query    = each.value
}

data "jq_query" "envs_params" {
  for_each = local.mapped_envs_params
  data     = jsonencode(local.params)
  query    = each.value
}
