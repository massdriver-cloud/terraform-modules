locals {
  # for the artifact?
  # name
  # resource_group_name
  virtual_network_name = regex(".*/virtual[n|N]etworks/(.*)$", var.virtual_network_id)[0]
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.region
  tags     = var.md_metadata.default_tags
}

resource "azurerm_subnet" "main" {
  name                 = var.md_metadata.name_prefix
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = local.virtual_network_name
  address_prefixes     = [cidrsubnet(module.auto_cidr.result, 1, 0)]
  # how many and which ones? what happens if we remove this completely
  service_endpoints = ["Microsoft.Storage"]
}
