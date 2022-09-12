module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=64e9223"
  name    = var.name
  service = "function"
}

data "azurerm_container_registry" "main" {
  count               = var.repo.repo_source == "Azure Container Registry" ? 1 : 0
  name                = var.repo.registry_name
  resource_group_name = var.repo.registry_resource_group
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.application.location

  tags = var.tags
}

resource "azurerm_service_plan" "main" {
  name                = var.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  os_type      = "Linux"
  sku_name     = var.application.sku_name
  worker_count = var.application.minimum_worker_count

  tags = var.tags
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
      custom_emails = [var.application.notification_email]
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

  https_only = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = true

    auto_heal_enabled = true
    health_check_path = "/health"
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
    container_registry_use_managed_identity = true

    dynamic "application_stack" {
      for_each = var.repo.repo_source == "Azure Container Registry" ? toset(["Azure Container Registry"]) : toset([])

      content {
        docker_image     = "${var.repo.registry_name}.azurecr.io/${var.repo.repo_name}"
        docker_image_tag = var.repo.tag
      }
    }

    dynamic "application_stack" {
      for_each = var.repo.repo_source == "DockerHub" ? toset(["DockerHub"]) : toset([])

      content {
        docker_image     = var.repo.docker_image
        docker_image_tag = var.repo.tag
      }
    }
  }

  depends_on = [
    azurerm_service_plan.main
  ]

  tags = var.tags
}

resource "azurerm_role_assignment" "main" {
  scope                = data.azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.main.identity[0].principal_id
}
