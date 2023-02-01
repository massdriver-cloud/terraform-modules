locals {
  full_domain = "${var.subdomain}.${var.dns_zone_name}"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_public_ip" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  # SKU Standard_v2 can only reference public ip with Regional Tier
  sku_tier          = "Regional"
  domain_name_label = var.subdomain
  tags              = var.tags
}
