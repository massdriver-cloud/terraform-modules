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
