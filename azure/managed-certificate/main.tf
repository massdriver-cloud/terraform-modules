resource "azurerm_key_vault" "main" {
  name                        = var.name
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
}

# Give KV secret permissions to the service principal that runs the Terraform apply itself
resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.main.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "SetIssuers",
    "Update"
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Restore",
    "Restore",
    "Set"
  ]
}

# Give KV secret read permissions to the service
# Most likely, this is the gateway service
resource "azurerm_key_vault_access_policy" "service" {
  key_vault_id = azurerm_key_vault.main.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = var.identity.principal_id

  # the certificate is accessed like a secret...
  secret_permissions = [
    "Get", "List"
  ]
}

# Sometimes after the key vault is created, it's not ready yet
# This is advice from issues on GH.
resource "time_sleep" "wait_240_seconds" {
  depends_on = [azurerm_key_vault.main]

  create_duration = "240s"
}
