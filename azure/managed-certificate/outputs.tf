output "ssl_certificate_name" {
  value = azurerm_key_vault_certificate.main.name
}

output "ssl_certificate_data" {
  value = azurerm_key_vault_certificate.main.certificate_data
}

output "key_vault_id" {
  value = azurerm_key_vault.main.id
}
output "key_vault_secret_id" {
  value = azurerm_key_vault_certificate.main.id
}

output "azurerm_key_vault_certificate_secret_id" {
  value = azurerm_key_vault_certificate.main.secret_id
}
