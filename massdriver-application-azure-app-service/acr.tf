locals {
  env_variables = {
    DOCKER_REGISTRY_SERVER_URL      = data.azurerm_container_registry.main.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.main.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.main.admin_password
  }
}

data "azurerm_container_registry" "main" {
  name                = var.acr.registry_name
  resource_group_name = var.acr.registry_resource_group
}