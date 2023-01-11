locals {
  token_response = var.enable_auto_cidr ? jsondecode(data.http.token.0.response_body) : {}
  token          = lookup(local.token_response, "access_token", "")
  cidr           = var.enable_auto_cidr ? utility_available_cidr.cidr.0.result : var.cidr
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.region
  tags     = var.md_metadata.default_tags
}

resource "azurerm_virtual_network" "main" {
  name                = var.md_metadata.name_prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = [local.cidr]
  tags                = var.md_metadata.default_tags
}

# leaving for backward-compat, but pretty sure we don't need this
# TODO: link ticket to think about how to measure this lifecycle through our distributed state files
resource "azurerm_subnet" "main" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(local.cidr, 1, 0)]
  service_endpoints    = ["Microsoft.Storage"]
}
