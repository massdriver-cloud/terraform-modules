resource "azurerm_user_assigned_identity" "main" {
  name                = "${var.name}-gateway"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
}
