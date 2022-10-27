locals {
  max_length           = 24
  storage_account_name = substr(replace(var.name, "/[^a-z0-9]/", ""), 0, local.max_length)
}

module "application" {
  source                      = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=22d422e"
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
  name                   = var.name
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  os_type                = "Linux"
  sku_name               = var.application.sku_name
  worker_count           = var.application.zone_balancing ? (var.application.minimum_worker_count * 3) : var.application.minimum_worker_count
  zone_balancing_enabled = var.application.zone_balancing
  tags                   = var.tags
}

resource "azurerm_linux_function_app" "main" {
  name                        = var.name
  resource_group_name         = azurerm_resource_group.main.name
  location                    = azurerm_resource_group.main.location
  service_plan_id             = azurerm_service_plan.main.id
  app_settings                = module.application.envs
  functions_extension_version = "~4"
  https_only                  = true
  storage_account_name        = azurerm_storage_account.main.name
  storage_account_access_key  = azurerm_storage_account.main.primary_access_key
  virtual_network_subnet_id   = azurerm_subnet.main.id
  tags                        = var.tags


  site_config {
    always_on                               = true
    application_insights_connection_string  = azurerm_application_insights.main.connection_string
    application_insights_key                = azurerm_application_insights.main.instrumentation_key
    app_scale_limit                         = var.application.maximum_worker_count
    container_registry_use_managed_identity = true
    ftps_state                              = "FtpsOnly"
    health_check_path                       = "/health"
    vnet_route_all_enabled                  = true

    application_stack {
      docker {
        registry_url = var.docker.registry
        image_name   = var.docker.image
        image_tag    = var.docker.tag
      }
    }

    app_service_logs {
      disk_quota_mb         = 50
      retention_period_days = 7
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
