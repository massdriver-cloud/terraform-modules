# Network security group for Virtual Machine Network Interface
resource "azurerm_network_security_group" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  tags                = var.tags
}

# resource "azurerm_network_security_rule" "main" {
#   name                        = var.name
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = data.azurerm_resource_group.main.name
#   network_security_group_name = azurerm_network_security_group.main.name
# }
