# maybe push into mdxc provider
resource "azurerm_role_assignment" "app_read_acr" {
  scope                = data.azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = module.application.azure_application_identity.service_principal_object_id
}