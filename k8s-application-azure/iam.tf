locals {
  // build a list of which connections need IAM policies, and the name of the policy: [{"connection": <connection_name>, "policy": <policy_name>},...]
  dependency_to_policy_map = [for dep_name, dep_spec in local.app_specification.dependencies : { "dependency" = dep_name, "policy" = lookup(dep_spec, "policy", null) } if lookup(dep_spec, "policy", "") != ""]
  // turn the above list into an actual list of IAM policy ARNs
  merged_policies = [for dep2pol in local.dependency_to_policy_map : lookup(local.connections, dep2pol.dependency, null)["data"]["security"]["policies"][dep2pol.policy]]

  service_principal_envs = [
    {
      name  = "AZURE_CLIENT_ID"
      value = azuread_service_principal.application.application_id
    },
    {
      name  = "AZURE_CLIENT_SECRET"
      value = azuread_service_principal_password.application.value
    },
    {
      name  = "AZURE_TENANT_ID"
      value = data.azurerm_client_config.current.tenant_id
    }
  ]
}

data "azurerm_client_config" "current" {
}

resource "azuread_application" "application" {
  display_name = var.md_metadata.name_prefix
}

resource "azuread_service_principal" "application" {
  application_id = azuread_application.application.application_id
}

resource "azuread_service_principal_password" "application" {
  service_principal_id = azuread_service_principal.application.id
}

resource "azurerm_role_assignment" "application" {
  for_each             = toset(local.merged_policies)
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  principal_id         = azuread_service_principal.application.id
  role_definition_name = each.key
}
