output "ssl_certificate_name" {
  value = azurerm_key_vault_certificate.main.name
}

output "ssl_certificate_secret_id" {
  value = azurerm_key_vault_certificate.main.secret_id
}
