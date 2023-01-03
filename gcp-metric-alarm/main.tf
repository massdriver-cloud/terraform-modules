locals {
  filter = "metric.type=\"${var.alarm_configuration.metric_type}\" AND resource.type=\"${var.alarm_configuration.resource_type}\" AND metadata.user_labels.md-package=\"${var.md_metadata.name_prefix}\""
  # this is used as the _required_ argument `display_name`, which is essentially the GUID for the alarm.
  # packages can have multiple alarms of each type, so we need more than the name_prefix here
  alarm_id = "${var.md_metadata.name_prefix}-${lower(replace(var.display_name, " ", ""))}"
}

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_resource_id = var.cloud_resource_id
}
