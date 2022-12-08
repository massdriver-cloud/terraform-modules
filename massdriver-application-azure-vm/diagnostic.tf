resource "azurerm_storage_account" "main" {
  # Not enabling CMKs because we don't have a way to manage the key vault yet.
  name                          = local.storage_account_name
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
  min_tls_version               = "TLS1_2"
  tags                          = var.tags

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices", "Logging", "Metrics"]
    virtual_network_subnet_ids = [data.azurerm_subnet.default.id]
  }
}
