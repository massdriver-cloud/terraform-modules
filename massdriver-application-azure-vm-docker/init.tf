# doing it this way because the `template` provider is deprecated
# and `templatefile` should be used instead
#
# notes, TODO: remove
# another example "runcmd: ['systemctl enable --now docker','docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest --acme-domain ${var.dns.subdomain}.${local.zone_name}']"
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
