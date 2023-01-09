locals {
  zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

module "dns" {
  count                      = var.dns.enable_dns ? 1 : 0
  source                     = "../azure/dns"
  subdomain                  = var.dns.subdomain
  tags                       = var.md_metadata.default_tags
  zone_name                  = local.zone_name
  resource_group_name        = azurerm_resource_group.main.name
  zone_resource_group_name   = local.zone_resource_group
  azurerm_linux_function_app = azurerm_linux_function_app.main
  # the data resource in this module uses var.resource_group_name
  depends_on = [
    azurerm_resource_group.main
  ]
}
