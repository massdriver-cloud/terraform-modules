locals {
  zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

module "dns" {
  source                   = "github.com/massdriver-cloud/terraform-modules//azure/dns?ref=9df7459"
  count                    = var.dns.enable_dns ? 1 : 0
  function_app             = azurerm_linux_function_app.main
  subdomain                = var.dns.subdomain
  resource_group_name      = azurerm_resource_group.main.name
  zone_name                = local.zone_name
  zone_resource_group_name = local.zone_resource_group
  tags                     = var.tags
  # the data resource in this module uses azurerm_resource_group.main
  # and the implicity dependency above _does not_ prevent it from trying to fetch
  # before the resource group has been created.
  depends_on = [
    azurerm_resource_group.main
  ]
}
