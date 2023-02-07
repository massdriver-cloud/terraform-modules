output "identity_id" {
  value = azurerm_user_assigned_identity.main.id
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.main.principal_id
}

output "client_id" {
  value = azurerm_user_assigned_identity.main.client_id
}

output "tenant_id" {
  value = azurerm_user_assigned_identity.main.tenant_id
}

output "endpoint" {
  value = azurerm_cognitive_account.main.endpoint
}

output "account_id" {
  value = azurerm_cognitive_account.main.id
}

output "account_name" {
  value = azurerm_cognitive_account.main.name
}

output "account_location" {
  value = azurerm_cognitive_account.main.location
}
