locals {
  alarm_id = "${var.md_metadata.name_prefix}-${var.metric_name}"
}

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
    action_group_id = var.monitor_action_group_id
    webhook_properties = merge(
      var.md_metadata.default_tags,
      {
        alarm_id = local.alarm_id
      }
    )
  }
  tags = var.md_metadata.default_tags
}

# resource "massdriver_package_alarm" "main" {
#   display_name      = var.display_name
#   cloud_resource_id = local.alarm_id
#   metric {
#     name      = var.metric_name
#     namespace = var.metric_namespace
#     statistic = var.aggregation
#     dimensions = tomap[{
#       "name" = "name"
#     }] #placeholder
#   }
# }
