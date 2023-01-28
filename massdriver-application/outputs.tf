output "cloud" {
  description = "The cloud provisioning executed in."
  value       = data.mdxc_cloud.current.cloud
}

output "policies" {
  description = "The policies parsed from massdriver.yaml"
  value       = local.policies
}

output "envs" {
  sensitive   = true
  description = "The environment (config & secrets) parsed from massdriver.yaml"
  value       = local.envs
}

output "params" {
  # We provide these as an output as its needed for passing into runtimes (helm, etc)
  # and we don't want end-developers to have to parse the write files to get them since
  # we've already done the work
  description = "Parameters provided to bundle."
  value       = local.params
}

output "id" {
  description = "Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity, etc)"
  value       = local.application_identity_id
}

output "identity" {
  description = "The full MDXC Cloud Identity object, for accessing additional values beyond the ID of the Identity."
  value       = mdxc_application_identity.main
}
