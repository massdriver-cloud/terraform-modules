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

  dynamic "queue_properties" {
    for_each = var.queue_properties != null ? toset(["true"]) : toset([])
    content {
      logging {
        delete                = var.queue_properties.logging.delete
        read                  = var.queue_properties.logging.read
        write                 = var.queue_properties.logging.write
        version               = var.queue_properties.logging.version
        retention_policy_days = var.queue_properties.logging.retention_policy_days
      }
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties != null ? toset(["true"]) : toset([])
    content {
      delete_retention_policy {
        days = var.blob_properties.delete_retention_policy
      }
      container_delete_retention_policy {
        days = var.blob_properties.container_delete_retention_policy
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
