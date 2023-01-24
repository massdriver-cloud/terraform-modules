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

# https://learn.microsoft.com/en-us/azure/developer/terraform/deploy-application-gateway-v2#2-implement-the-terraform-code

# https://learn.microsoft.com/en-us/azure/developer/terraform/deploy-application-gateway-v2
# resource "azurerm_network_interface" "main" {
#   name                = "nic"
#   location            = data.azurerm_resource_group.main.location
#   resource_group_name = data.azurerm_resource_group.main.name

#   ip_configuration {
#     name                          = "nic-ipconfig"
#     subnet_id                     = var.subnet_id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

output "v" {
  value = azurerm_application_gateway.main.backend_address_pool
}

# resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "main" {
#   network_interface_id    = azurerm_network_interface.main.id
#   ip_configuration_name   = "nic-ipconfig"
#   backend_address_pool_id = azurerm_application_gateway.main.backend_address_pool.*.id
# }
