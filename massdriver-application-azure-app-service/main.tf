module "application" {
  source                      = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=9e3a1b4"
  name                        = var.name
  service                     = "function"
  application_identity_id     = azurerm_linux_web_app.main.identity[0].principal_id
  create_application_identity = false
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

resource "azurerm_service_plan" "main" {
  name                   = var.name
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  os_type                = "Linux"
  sku_name               = var.application.sku_name
  worker_count           = var.application.zone_balancing ? (var.application.minimum_worker_count * 3) : var.application.minimum_worker_count
  zone_balancing_enabled = var.application.zone_balancing
  tags                   = var.tags
}

resource "azurerm_linux_web_app" "main" {
  name                = var.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id
  https_only          = true
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

  # To get application logs, we need to set app logging level and retention.
  logs {
    application_logs {
      file_system_level = "Error"
    }
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  # https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration#regional-virtual-network-integration
  virtual_network_subnet_id = azurerm_subnet.main.id

  site_config {
    always_on                               = true
    auto_heal_enabled                       = true
    health_check_path                       = "/health"
    container_registry_use_managed_identity = true
    ftps_state                              = "FtpsOnly"

    auto_heal_setting {
      action {
        action_type = "Recycle"
      }
      trigger {
        requests {
          count    = 5
          interval = "00:01:00"
        }
        slow_request {
          count      = 5
          interval   = "00:01:00"
          time_taken = "00:00:10"
        }
        status_code {
          count             = 5
          interval          = "00:01:00"
          status_code_range = "400-510"
        }
      }
    }

    application_stack {
      docker_image     = var.image.repository
      docker_image_tag = var.image.tag
    }

    app_command_line = var.command
  }

  app_settings = module.application.envs

  depends_on = [
    azurerm_service_plan.main
  ]
}

data "azurerm_client_config" "main" {
}

resource "azurerm_role_assignment" "main" {
  scope                = "/subscriptions/${data.azurerm_client_config.main.subscription_id}"
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.main.identity[0].principal_id
}
