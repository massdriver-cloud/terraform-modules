module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=a3371df"
  name    = module.application.params.md_metadata.name_prefix
  service = "function"
}

resource "azuread_application" "main" {
  display_name = var.md_metadata.name_prefix
}

resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.object_id
}

resource "azurerm_role_assignment" "app_read_acr" {
  scope                = data.azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.main.object_id
}

resource "azurerm_resource_group" "main" {
  name     = var.md_metadata.name_prefix
  location = var.vnet.specs.azure.region
}

resource "azurerm_service_plan" "main" {
  name                = var.md_metadata.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  os_type      = "Linux"
  sku_name     = var.application.sku_name
  worker_count = var.application.minimum_worker_count
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = var.md_metadata.name_prefix
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
      custom_emails = [var.application.notification_email]
    }
  }

  depends_on = [
    azurerm_service_plan.main
  ]
}

resource "azurerm_linux_web_app" "main" {
  name                = var.md_metadata.name_prefix
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  https_only = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = true

    auto_heal_enabled = true
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
    health_check_path = "/health"

    application_stack {
      docker_image     = "${var.acr.registry_name}.azurecr.io/${var.acr.repo_name}"
      docker_image_tag = var.acr.tag
    }
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = data.azurerm_container_registry.main.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = azuread_service_principal.main.application_id
    DOCKER_REGISTRY_SERVER_PASSWORD = azuread_service_principal_password.main.value
  }

  depends_on = [
    azurerm_service_plan.main
  ]
}
