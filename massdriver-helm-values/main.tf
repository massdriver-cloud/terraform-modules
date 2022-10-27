locals {
  common_labels = var.massdriver_application.params.md_metadata.default_tags
  deployment_id = lookup(var.massdriver_application.params.md_metadata.deployment, "id", "")
  envs          = var.massdriver_application.envs
}
