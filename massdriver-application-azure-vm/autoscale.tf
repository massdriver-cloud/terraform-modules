locals {
  preset_autoscaling = {
    cpu_scale_up = {
      operator         = "GreaterThan"
      statistic        = "Average"
      threshold        = 75
      time_grain       = "PT1M"
      time_window      = "PT5M"
      time_aggregation = "Average"
      scale_action = {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
    cpu_scale_down = {
      operator         = "LessThan"
      statistic        = "Average"
      threshold        = 25
      time_grain       = "PT1M"
      time_window      = "PT5M"
      time_aggregation = "Average"
      scale_action = {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
  autoscaling_map = {
    "AUTOMATED" = local.preset_autoscaling
    "DISABLED"  = {}
    "CUSTOM"    = lookup(var.autoscaling, "autoscaling", {})
  }
  autoscaling = lookup(local.autoscaling_map, var.autoscaling.mode, {})
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id

  profile {
    name = "defaultProfile"

    capacity {
      default = var.scaleset.enable_scaleset ? var.scaleset.instances : 1
      minimum = var.scaleset.enable_scaleset ? var.scaleset.instances : 1
      maximum = var.scaleset.enable_scaleset ? var.scaleset.max_instances : 1
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = local.autoscaling.cpu_scale_up.time_grain
        statistic          = local.autoscaling.cpu_scale_up.statistic
        time_window        = local.autoscaling.cpu_scale_up.time_window
        time_aggregation   = local.autoscaling.cpu_scale_up.time_aggregation
        operator           = local.autoscaling.cpu_scale_up.operator
        threshold          = local.autoscaling.cpu_scale_up.threshold
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
      }

      scale_action {
        direction = local.autoscaling.cpu_scale_up.scale_action.direction
        type      = local.autoscaling.cpu_scale_up.scale_action.type
        value     = local.autoscaling.cpu_scale_up.scale_action.value
        cooldown  = local.autoscaling.cpu_scale_up.scale_action.cooldown
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = local.autoscaling.cpu_scale_down.time_grain
        statistic          = local.autoscaling.cpu_scale_down.statistic
        time_window        = local.autoscaling.cpu_scale_down.time_window
        time_aggregation   = local.autoscaling.cpu_scale_down.time_aggregation
        operator           = local.autoscaling.cpu_scale_down.operator
        threshold          = local.autoscaling.cpu_scale_down.threshold
      }

      scale_action {
        direction = local.autoscaling.cpu_scale_down.scale_action.direction
        type      = local.autoscaling.cpu_scale_down.scale_action.type
        value     = local.autoscaling.cpu_scale_down.scale_action.value
        cooldown  = local.autoscaling.cpu_scale_down.scale_action.cooldown
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = [var.contact_email]
    }
  }
}
