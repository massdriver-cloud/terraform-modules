output "cloud" {
  description = "The cloud provisioning executed in."
  value       = data.mdxc_cloud.current.cloud
}

output "policies" {
  description = "The policies parsed from massdriver.yaml"
  value       = local.policies
}

output "envs" {
  description = "A key/value map of environment variables for the bundle."
  value       = local.envs
}

output "secrets" {
  # This should probably be marked as sensitive "true" but that breaks dynamic blocks, which are needed for setting envs in some instances
  # https://github.com/hashicorp/terraform/issues/29744
  description = "A key/value map of secrets for the bundle."
  value       = local.secrets
}

output "envs_and_secrets" {
  description = "A combined key/value map of both environment variables and secrets. This is usually used to set all the environment variables."
  value       = merge(local.envs, local.secrets)
}

output "params" {
  # We provide these as an output as its needed for passing into runtimes (helm, etc)
  # and we don't want end-developers to have to parse the write files to get them since
  # we've already done the work
  description = "Parameters provided to bundle."
  value       = local.params
}

output "connections" {
  # We provide these as an output as its needed for passing into runtimes (helm, etc)
  # and we don't want end-developers to have to parse the write files to get them since
  # we've already done the work
  description = "Connections provided to bundle."
  value       = local.connections
}

output "identity" {
  description = "Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity, etc)"
  value       = local.application_identity_id
}

output "identity_block" {
  description = "The full MDXC Cloud Identity object, for accessing additional values beyond the ID of the Identity."
  value       = mdxc_application_identity.main
  sensitive   = true
}
