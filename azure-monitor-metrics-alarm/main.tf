resource "azurerm_monitor_metric_alert" "main" {
  name                = var.alarm_name
  resource_group_name = var.resource_group_name
  scopes              = var.scopes
  description         = var.message

  severity    = var.severity
  frequency   = var.frequency
  window_size = var.window_size

  criteria {
    metric_namespace = var.metric_namespace
    metric_name      = var.metric_name
    aggregation      = var.aggregation
    operator         = var.operator
    threshold        = var.threshold

    dynamic "dimension" {
      for_each = { for dimension in var.dimensions : dimension.name => dimension }
      content {
        name     = dimension.value.name
        operator = dimension.value.operator
        values   = dimension.value.values
      }
    }
  }

  action {
    action_group_id    = var.monitor_action_group_id
    webhook_properties = var.md_metadata.default_tags
  }
  tags = var.md_metadata.default_tags
}

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_resource_id = azurerm_monitor_metric_alert.main.id
}
