locals {
  automated_alarms = {
    latency_metric_alert = {
      severity    = "1"
      frequency   = "PT1M"
      window_size = "PT5M"
      operator    = "GreaterThan"
      aggregation = "Average"
      threshold   = 1000
    }
  }
  alarms_map = {
    "AUTOMATED" = local.automated_alarms
    "DISABLED"  = {}
    "CUSTOM"    = lookup(var.monitoring, "alarms", {})
  }
  alarms = lookup(local.alarms_map, var.monitoring.mode, {})
}

resource "azurerm_application_insights" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  application_type    = "other"
  tags                = var.tags
}

module "alarm_channel" {
  source              = "github.com/massdriver-cloud/terraform-modules//azure-alarm-channel?ref=40d6e54"
  md_metadata         = var.md_metadata
  resource_group_name = azurerm_resource_group.main.name
}

module "latency_metric_alert" {
  count                   = lookup(local.alarms, "latency_metric_alert", null) == null ? 0 : 1
  source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
  scopes                  = [azurerm_application_insights.main.id]
  resource_group_name     = azurerm_resource_group.main.name
  monitor_action_group_id = module.alarm_channel.id
  severity                = local.alarms.latency_metric_alert.severity
  frequency               = local.alarms.latency_metric_alert.frequency
  window_size             = local.alarms.latency_metric_alert.window_size

  depends_on = [
    azurerm_application_insights.main
  ]

  md_metadata  = var.md_metadata
  display_name = "Latency"
  message      = "High latency"

  alarm_name       = "${var.name}-highLatency"
  operator         = local.alarms.latency_metric_alert.operator
  metric_name      = "requests/duration"
  metric_namespace = "microsoft.insights/components"
  aggregation      = local.alarms.latency_metric_alert.aggregation
  threshold        = local.alarms.latency_metric_alert.threshold
}
