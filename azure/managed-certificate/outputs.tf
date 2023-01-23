output "ssl_certificate_name" {
  value = azurerm_key_vault_certificate.main.name
}

output "key_vault_id" {
  value = azurerm_key_vault.main.id
}
