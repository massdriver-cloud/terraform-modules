locals {
  max_length           = 24
  storage_account_name = substr(replace(var.name, "/[^a-z0-9]/", ""), 0, local.max_length)
}

module "application" {
  source                      = "../massdriver-application" # "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=9e3a1b4"
  name                        = var.name
  service                     = "function"
  application_identity_id     = azurerm_linux_function_app.main.identity[0].principal_id
  create_application_identity = false
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.application.location
  tags     = var.tags
}

resource "azurerm_service_plan" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = var.application.sku_name
  tags                = var.tags
}

resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }
}

resource "azurerm_linux_function_app" "main" {
  name                       = var.name
  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  service_plan_id            = azurerm_service_plan.main.id
  https_only                 = true
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  functions_extension_version = "~3"
  tags                       = var.tags

  site_config {
    always_on                               = true
    health_check_path                       = "/health"
    container_registry_use_managed_identity = true
    ftps_state                              = "FtpsOnly"
    app_scale_limit                         = var.application.maximum_worker_count

    application_stack {
      docker {
        registry_url = var.docker.registry
        image_name   = var.docker.image
        image_tag    = var.docker.tag
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_service_plan.main
  ]
}

data "azurerm_client_config" "main" {
}

resource "azurerm_role_assignment" "acr" {
  scope                = "/subscriptions/${data.azurerm_client_config.main.subscription_id}"
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_function_app.main.identity[0].principal_id
}
