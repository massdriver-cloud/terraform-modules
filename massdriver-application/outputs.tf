output "cloud" {
  description = "The cloud provisioning executed in."
  value       = data.mdxc_cloud.current.cloud
}

output "policies" {
  description = "The policies parsed from massdriver.yaml"
  value       = local.policies
}

output "envs" {
  description = "The policies parsed from massdriver.yaml"
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
  description = "Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Service Account, etc)"
  value       = local.pplication_identity_id
}
