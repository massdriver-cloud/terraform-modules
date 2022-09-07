data "azurerm_container_registry" "main" {
  name                = var.acr.registry_name
  resource_group_name = var.acr.registry_resource_group
}