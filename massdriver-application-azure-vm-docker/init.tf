locals {
  environment_variables = [for env_key, env_val in module.application.envs : "-e ${env_key}=${env_val}"]

  cloud_init_rendered = templatefile("${path.module}/templates/cloud-init.tmpl",
    {
      container_port        = var.port
      container_image       = var.container.repository
      container_tag         = var.container.tag
      environment_variables = join(" ", local.environment_variables)
    }
  )
}

# debugging
# output "cloud_init_rendered" {
#   value = local.cloud_init_rendered
# }
