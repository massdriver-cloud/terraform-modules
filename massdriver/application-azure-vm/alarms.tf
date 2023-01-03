# locals {
#   automated_alarms = {
#     cpu_metric_alert = {
#       severity    = "1"
#       frequency   = "PT1M"
#       window_size = "PT5M"
#       operator    = "GreaterThan"
#       aggregation = "Average"
#       threshold   = 90
#     }
#   }
#   alarms_map = {
#     "AUTOMATED" = local.automated_alarms
#     "DISABLED"  = {}
#     "CUSTOM"    = lookup(var.monitoring, "alarms", {})
#   }
#   alarms = lookup(local.alarms_map, var.monitoring.mode, {})
# }

# module "alarm_channel" {
#   source              = "github.com/massdriver-cloud/terraform-modules//azure-alarm-channel?ref=40d6e54"
#   md_metadata         = var.md_metadata
#   resource_group_name = azurerm_resource_group.main.name
# }

# module "cpu_metric_alert" {
#   count                   = lookup(local.alarms, "cpu_metric_alert", null) == null ? 0 : 1
#   source                  = "github.com/massdriver-cloud/terraform-modules//azure-monitor-metrics-alarm?ref=40d6e54"
#   scopes                  = [azurerm_linux_virtual_machine_scale_set.main.id]
#   resource_group_name     = azurerm_resource_group.main.name
#   monitor_action_group_id = module.alarm_channel.id
#   severity                = local.alarms.cpu_metric_alert.severity
#   frequency               = local.alarms.cpu_metric_alert.frequency
#   window_size             = local.alarms.cpu_metric_alert.window_size

#   depends_on = [
#     azurerm_linux_virtual_machine_scale_set.main
#   ]

#   md_metadata  = var.md_metadata
#   display_name = "CPU usage"
#   message      = "High CPU usage"

#   alarm_name       = "${var.md_metadata.name_prefix}-highCPUUsage"
#   operator         = local.alarms.cpu_metric_alert.operator
#   metric_name      = "Percentage CPU"
#   metric_namespace = "microsoft.compute/virtualmachinescalesets"
#   aggregation      = local.alarms.cpu_metric_alert.aggregation
#   threshold        = local.alarms.cpu_metric_alert.threshold
# }
