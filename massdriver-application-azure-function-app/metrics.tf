resource "azurerm_application_insights" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  application_type    = "other"
  tags                = var.tags
}
