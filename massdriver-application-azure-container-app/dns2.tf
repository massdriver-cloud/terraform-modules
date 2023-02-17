# locals {
#   zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
#   zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
# }

# module "dns" {
#   count                    = var.dns.enable_dns ? 1 : 0
#   # source                   = "github.com/massdriver-cloud/terraform-modules//azure/dns?ref=9df7459"
#   source = "../azure/dns"
#   subdomain                = var.dns.subdomain
#   service_name              = azurerm_container_app.main.name
#   txt_record = azurerm_container_app.main.custom_domain_verification_id
#   cname_record =  azurerm_container_app.main.latest_revision_fqdn
#   resource_group_name      = azurerm_resource_group.main.name
#   zone_name                = local.zone_name
#   zone_resource_group_name = local.zone_resource_group
#   tags                     = var.tags
#   # the data resource in this module uses azurerm_resource_group.main
#   # and the implicity dependency above _does not_ prevent it from trying to fetch
#   # before the resource group has been created.
#   depends_on = [
#     azurerm_resource_group.main,
#     azurerm_container_app.main,
#   ]
# }
