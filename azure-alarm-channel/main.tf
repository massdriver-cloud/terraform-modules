variable "md_metadata" {
  description = "Massdriver package metadata object."
  type        = any
}

variable "resource_group_name" {
  description = "Massdriver package Azure Resource Group name"
  type        = string
}

resource "azurerm_monitor_action_group" "main" {
  name                = "${var.md_metadata.name_prefix}-alarms"
  short_name          = "MD Alarms"
  resource_group_name = var.resource_group_name

  webhook_receiver {
    name                    = "Massdriver Observability Webhook API"
    service_uri             = var.md_metadata.observability.alarm_webhook_url
    use_common_alert_schema = true
  }
}

output "id" {
  description = "Alarm Channel Action Group ID"
  value       = azurerm_monitor_action_group.main.id
}
