output "params" {
  description = "Parameters provided to bundle."
  value       = local.params
}

output "connections" {
  description = "Connections provided to bundle."
  value       = local.connections
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

output "config" {
  description = "The massdriver.yaml configuration for the provisioner."
  value       = local.config
}
