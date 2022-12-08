data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "package_upgrade: true"
  }

  part {
    content_type = "text/cloud-config"
    content      = "packages: ['docker']"  
  }

  part {
    content_type = "text/cloud-config"
    content      = "runcmd: ['systemctl enable --now docker','docker run -d --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:latest --acme-domain ${var.dns.subdomain}.${local.zone_name}']"
  }

  depends_on = [
    azurerm_public_ip.main
  ]
}