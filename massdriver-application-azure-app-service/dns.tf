locals {
  zone_split_id       = var.dns.enable_dns ? split("/", var.dns.zone_id) : []
  zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

module "dns" {
  count                    = var.dns.enable_dns ? 1 : 0
  source                   = "../azure/dns"
  subdomain                = var.dns.subdomain
  zone_name                = local.zone_name
  zone_resource_group_name = local.zone_resource_group
  resource_group_name      = azurerm_resource_group.main.name
  azurerm_linux_web_app    = azurerm_linux_web_app.main
  tags                     = var.md_metadata.default_tags
}
