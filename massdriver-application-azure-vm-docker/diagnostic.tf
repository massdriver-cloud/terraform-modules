# resource "azurerm_storage_account" "main" {
#   name                     = local.storage_account_name
#   resource_group_name      = azurerm_resource_group.main.name
#   location                 = azurerm_resource_group.main.location
#   account_tier             = "Standard"
#   account_kind             = "StorageV2"
#   account_replication_type = "LRS"
#   # temporary
#   public_network_access_enabled = true
#   min_tls_version               = "TLS1_2"
#   tags                          = var.tags

#   queue_properties {
#     logging {
#       delete                = true
#       read                  = true
#       write                 = true
#       version               = "1.0"
#       retention_policy_days = 7
#     }
#   }

#   identity {
#     type = "SystemAssigned"
#   }
# }
