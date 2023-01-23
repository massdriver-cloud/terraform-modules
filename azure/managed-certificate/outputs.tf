data "azurerm_key_vault_certificate" "main" {
  name         = var.name
  key_vault_id = azurerm_key_vault.main.id
}

output "ssl_certificate_name" {
  value = azurerm_key_vault_certificate.main.name
}

output "ssl_certificate_data" {
  value = data.azurerm_key_vault_certificate.main.certificate_data
}

output "key_vault_id" {
  value = azurerm_key_vault.main.id
}
