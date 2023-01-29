locals {
  environment_variables = [for env_key, env_val in module.application.envs : "-e ${env_key}=${env_val}"]

  with_more = concat(local.environment_variables, [
    "-e AZURE_CLIENT_ID=${module.application.identity.azure_application_identity.client_id}",
    "-e AZURE_TENANT_ID=${module.application.identity.azure_application_identity.tenant_id}"
  ])

  cloud_init_rendered = templatefile("${path.module}/templates/cloud-init.tmpl",
    {
      container_port        = var.port
      container_image       = var.container.repository
      container_tag         = var.container.tag
      environment_variables = join(" ", local.with_more)
    }
  )
}

# debugging
# output "cloud_init_rendered" {
#   value = local.cloud_init_rendered
# }
