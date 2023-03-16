locals {
  max_length        = 24
  alphanumeric_name = substr(replace(var.name, "/[^a-z0-9]/", ""), 0, local.max_length)
}

resource "azurerm_storage_account" "main" {
  name                          = local.alphanumeric_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_kind                  = var.kind
  account_tier                  = var.tier
  account_replication_type      = var.replication_type
  access_tier                   = var.access_tier
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true
  is_hns_enabled                = var.enable_data_lake
  tags                          = var.tags

  # This is a recommendation from BridgeCrew to enable queue logging for storage accounts.
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
