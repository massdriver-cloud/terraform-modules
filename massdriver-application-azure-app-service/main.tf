module "application" {
  # source                  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=4001e6c"
  source  = "../massdriver-application"
  name    = "sp-${var.md_metadata.name_prefix}"
  service = "function"
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.location
  tags     = var.md_metadata.default_tags
}

resource "azurerm_service_plan" "main" {
  name                   = var.md_metadata.name_prefix
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  os_type                = "Linux"
  sku_name               = var.application.sku_name
  worker_count           = var.application.zone_balancing ? (var.application.minimum_worker_count * 3) : var.application.minimum_worker_count
  zone_balancing_enabled = var.application.zone_balancing
  tags                   = var.md_metadata.default_tags
}

resource "azurerm_linux_web_app" "main" {
  name                = var.md_metadata.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id
  https_only          = true
  tags                = var.md_metadata.default_tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }

  # To get application logs, we need to set app logging level and retention.
  logs {
    failed_request_tracing  = true
    detailed_error_messages = true
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
    health_check_path                       = var.health_check.path
    http2_enabled                           = true
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
