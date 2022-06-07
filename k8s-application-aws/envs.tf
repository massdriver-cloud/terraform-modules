locals {
  // extract flattened list of all environmetn variables, while mutating to append dependency (connection) name to front of path
  merged_envs = flatten([for dependency in local.app_specification.dependencies : [
    for env in lookup(dependency, "envs", []) : [
      { name = env.name, value = ".${dependency.field}.${env.path}" }
    ]
  ]])
  mapped_envs = { for env in local.merged_envs : env.name => env.value }
  result_envs = [for name, value in local.mapped_envs : { name = name, value = jsondecode(data.jq_query.envs["${name}"].result) }]
}

data "jq_query" "envs" {
  for_each = local.mapped_envs
  data     = jsonencode(local.connections)
  query    = each.value
}
