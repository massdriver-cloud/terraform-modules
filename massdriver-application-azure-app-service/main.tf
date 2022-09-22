module "application" {
  source                      = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=9e3a1b4"
  name                        = var.name
  service                     = "function"
  application_identity_id     = azurerm_linux_web_app.main.identity[0].principal_id
  create_application_identity = false
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.application.location
  tags     = var.tags
}

resource "azurerm_service_plan" "main" {
  name                = var.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = var.application.sku_name
  worker_count        = var.application.minimum_worker_count
  tags                = var.tags
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  target_resource_id  = azurerm_service_plan.main.id
  enabled             = true

  profile {
    name = "autoscale-profile"

    capacity {
      default = azurerm_service_plan.main.worker_count
      minimum = azurerm_service_plan.main.worker_count
      maximum = var.application.maximum_worker_count
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_service_plan.main.id
        time_grain         = "PT5M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
  notification {
    email {
      custom_emails = [var.contact_email]
    }
  }

  depends_on = [
    azurerm_service_plan.main
  ]
  tags = var.tags
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
