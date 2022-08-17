locals {
  app_policies = lookup(local.app_block, "policies", [])

  dependency_to_policy_map = flatten([for policy in local.app_policies :
    {
      "dependency" = split(policy, ".")[1],
      "policies"   = [split(policy, ".")[4]]
    }
    if true]
  )
  # for _every_ dependency (1-to-many)
  #   for _every_ policy (1-to-many)
  # creates an array of objects with the following structure:
  # {
  #   "<dependency-name>-policy": {
  #     AWS
  #       "policy_arn": <policy-arn>
  #     Azure
  #       "role": "Role name",
  #       "scope": "resource.name.startsWith...."
  #     GCP
  #       "role": "roles/xyz",
  #       "condition": "service.startsWith("service-name")"
  # },
  # }
  merged_policies = flatten(
    [for dep2pol in local.dependency_to_policy_map :
      [for policy in dep2pol.policies :
    { "${dep2pol.dependency}-${policy}" = lookup(local.connections, dep2pol.dependency, null)["data"]["security"]["iam"][policy] }]]
  )
}
