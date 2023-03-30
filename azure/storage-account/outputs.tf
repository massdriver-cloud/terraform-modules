output "account_id" {
  value = azurerm_storage_account.main.id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.main.primary_blob_endpoint
}

# Secondary endpoints are outputted for use in the event of a failover.
# When a storage account with geo-replication enabled fails over, the secondary endpoint becomes the primary endpoint.

output "secondary_blob_endpoint" {
  value = azurerm_storage_account.main.secondary_blob_endpoint
}

output "primary_queue_endpoint" {
  value = azurerm_storage_account.main.primary_queue_endpoint
}

output "secondary_queue_endpoint" {
  value = azurerm_storage_account.main.secondary_queue_endpoint
}

output "primary_table_endpoint" {
  value = azurerm_storage_account.main.primary_table_endpoint
}

output "secondary_table_endpoint" {
  value = azurerm_storage_account.main.secondary_table_endpoint
}

output "primary_file_endpoint" {
  value = azurerm_storage_account.main.primary_file_endpoint
}

output "secondary_file_endpoint" {
  value = azurerm_storage_account.main.secondary_file_endpoint
}

output "primary_dfs_endpoint" {
  value = azurerm_storage_account.main.primary_dfs_endpoint
}

output "secondary_dfs_endpoint" {
  value = azurerm_storage_account.main.secondary_dfs_endpoint
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.main.primary_web_endpoint
}

output "secondary_web_endpoint" {
  value = azurerm_storage_account.main.secondary_web_endpoint
}

output "identity_id" {
  value = azurerm_storage_account.main.identity.0.principal_id
}
