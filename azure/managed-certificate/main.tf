resource "azurerm_key_vault" "main" {
  name                        = var.name
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  # depends_on = [azurerm_key_vault_access_policy.main]

  # https://github.com/hashicorp/terraform-provider-azurerm/issues/4569
  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = data.azurerm_client_config.current.tenant_id

  #   certificate_permissions = [
  #     "Create",
  #     "Delete",
  #     "DeleteIssuers",
  #     "Get",
  #     "GetIssuers",
  #     "Import",
  #     "List",
  #     "ListIssuers",
  #     "ManageContacts",
  #     "ManageIssuers",
  #     "Purge",
  #     "SetIssuers",
  #     "Update"
  #   ]

  #   key_permissions = [
  #     "Backup",
  #     "Create",
  #     "Decrypt",
  #     "Delete",
  #     "Encrypt",
  #     "Get",
  #     "Import",
  #     "List",
  #     "Purge",
  #     "Recover",
  #     "Restore",
  #     "Sign",
  #     "UnwrapKey",
  #     "Update",
  #     "Verify",
  #     "WrapKey"
  #   ]

  #   secret_permissions = [
  #     "Backup",
  #     "Delete",
  #     "Get",
  #     "List",
  #     "Purge",
  #     "Restore",
  #     "Restore",
  #     "Set"
  #   ]
  # }

  # access_policy {
  #   object_id = var.managed_identity_id
  #   tenant_id = data.azurerm_client_config.current.tenant_id

  #   secret_permissions = [
  #     "Get"
  #   ]
  # }
}

# Give KV secret permissions to the service principal that runs the Terraform apply itself
resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.main.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "List", "Delete", "Purge", "Set", "Backup", "Restore", "Recover"
  ]
}

# Give KV secret read permissions to the service
resource "azurerm_key_vault_access_policy" "service" {
  key_vault_id = azurerm_key_vault.main.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = var.user_assigned_identity_principal_id

  secret_permissions = [
    "Get", "List"
  ]
}

# resource "time_sleep" "wait_240_seconds" {
#   depends_on = [azurerm_key_vault.main]

#   create_duration = "240s"
# }
