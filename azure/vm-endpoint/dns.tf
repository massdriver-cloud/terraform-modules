# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#attributes-reference
# Public IP Addresses aren't allocated until they're attached to a device (e.g. a Virtual Machine/Load Balancer).
# Instead you can obtain the IP Address once the Public IP has been assigned via the azurerm_public_ip Data Source.
data "azurerm_public_ip" "main" {
  name                = azurerm_public_ip.main.name
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_dns_a_record" "main" {
  name                = var.subdomain
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
  ttl                 = 300
  records             = [data.azurerm_public_ip.main.ip_address]
}
