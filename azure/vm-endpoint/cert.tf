# It seems like Azure can create a managed cert
# But it forces you to use key vault to do that
resource "azurerm_api_management" "main" {
  name                = "example-apim"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  publisher_name      = "pub1"
  publisher_email     = "pub1@email.com"
  sku_name            = "Developer_1"
}

# resource "azurerm_api_management_certificate" "main" {
#   name                = var.name
#   api_management_name = azurerm_api_management.example.name
#   resource_group_name = azurerm_resource_group.example.name
#   data                = filebase64("example.pfx")
# }

resource "azurerm_api_management_custom_domain" "example" {
  api_management_id = azurerm_api_management.example.id

  gateway {
    host_name    = "api.example.com"
    # module.managed_cert.ssl_certificate_name
    key_vault_id = azurerm_key_vault_certificate.example.secret_id
  }
}
