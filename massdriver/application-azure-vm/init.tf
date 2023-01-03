# doing it this way because the `template` provider is deprecated
# and `templatefile` should be used instead
#
# notes, TODO: remove
# another example "runcmd: ['systemctl enable --now docker','docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest --acme-domain ${var.dns.subdomain}.${local.zone_name}']"
locals {
  systemd_svc_rendered = templatefile("${path.module}/templates/systemd-service.tmpl", {})
  cloud_init_rendered = templatefile("${path.module}/templates/cloud-init.tmpl",
    {
      systemd_service_file_b64 = base64encode(local.systemd_svc_rendered)
      docker_compose_file_b64  = "dmVyc2lvbjogIjMiCgpzZXJ2aWNlczoKICBhcHA6CiAgICBpbWFnZTogbmdpbng6bGF0ZXN0Cg=="
      container_config_files = {
        conf = {
          host_path        = "/etc/composer/nginx.conf"
          file_content_b64 = base64encode(file("./configfiles/nginx.conf"))
        },
        index001 = {
          host_path        = "/etc/composer/index001.html"
          file_content_b64 = base64encode(file("./configfiles/index001.html"))
        },
        index002 = {
          host_path        = "/etc/composer/index002.html"
          file_content_b64 = base64encode(file("./configfiles/index002.html"))
        }
      }
    }
  )
}
