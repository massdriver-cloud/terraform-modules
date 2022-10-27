output "common_labels" {
  value = module.application.params.md_metadata.default_tags
}

output "envs" {
  value = module.application.envs
}

output "md_deployment_id" {
  value = lookup(module.application.params.md_metadata.deployment, "id", "")
}

output "k8s_service_account" {
  value = local.service_account
}

output "mdx_application" {
  value = module.application
}
