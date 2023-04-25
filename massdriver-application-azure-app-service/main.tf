module "application" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=d9f4961"
  name                = var.name
  service             = "function"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
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
  name                       = var.name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  service_plan_id            = azurerm_service_plan.main.id
  https_only                 = true
  client_certificate_enabled = true
  client_certificate_mode    = "Optional"
  tags                       = var.tags

  app_settings = merge(module.application.envs, {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.main.instrumentation_key}",
    "APPINSIGHTS_CONNECTION_STRING"  = "${azurerm_application_insights.main.connection_string}",
    # This environment variable enables application insights: (https://github.com/hashicorp/terraform-provider-azurerm/issues/19653#issuecomment-1347802887)
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3",
  })

  identity {
    type = "UserAssigned"
    identity_ids = [
      module.application.identity.azure_application_identity.resource_id,
      azurerm_user_assigned_identity.container.id
    ]
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
    always_on                                     = true
    auto_heal_enabled                             = true
    health_check_path                             = var.health_check.path
    http2_enabled                                 = true
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.container.client_id
    ftps_state                                    = "FtpsOnly"
    vnet_route_all_enabled                        = true

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
      # configuring the structure this way so that the image block in massdriver.yaml is identical across azure runtimes
      docker_image     = "${var.image.registry}/${var.image.name}"
      docker_image_tag = var.image.tag
    }

    app_command_line = var.command
  }

  depends_on = [
    azurerm_service_plan.main
  ]
}
