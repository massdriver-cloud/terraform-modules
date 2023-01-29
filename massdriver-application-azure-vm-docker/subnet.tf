locals {
  virtual_network_name                = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
  virtual_network_resource_group_name = regex(".*/resource[g|G]roups/(.*)/providers", var.virtual_network_id)[0]
}

module "auto_cidr" {
  source             = "github.com/massdriver-cloud/terraform-modules//azure/auto-cidr?ref=93bc06c"
  network_mask       = 22
  virtual_network_id = var.virtual_network_id
}

resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = local.virtual_network_resource_group_name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = [module.auto_cidr.cidr]
  service_endpoints    = ["Microsoft.Web", "Microsoft.Storage"]
}
