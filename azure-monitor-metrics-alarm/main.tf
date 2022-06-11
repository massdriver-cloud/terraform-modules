locals {
  enable_alarms = lookup(var.md_metadata.observability.alarm_channels, "azure", null) != null
}

resource "azurerm_monitor_metric_alert" "main" {
  count               = local.enable_alarms ? 1 : 0
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
    action_group_id    = var.md_metadata.observability.alarm_channels.azure.ari
    webhook_properties = var.md_metadata.default_tags
  }
  tags = var.md_metadata.default_tags
}
