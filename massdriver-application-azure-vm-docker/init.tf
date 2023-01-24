locals {
  cloud_init_rendered = templatefile("${path.module}/templates/cloud-init.tmpl",
    {
      container_port  = 80
      container_image = var.container.repository
      container_tag   = var.container.tag
    }
  )
}

# debugging
# output "cloud_init_rendered" {
#   value = local.cloud_init_rendered
# }
