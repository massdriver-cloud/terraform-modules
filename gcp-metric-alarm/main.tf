locals {
  uuid            = lower(replace(var.display_name, " ", ""))
  alarm_unique_id = "${var.md_metadata.name_prefix}-${local.uuid}"
  filter          = "metric.type=\"${var.alarm_configuration.metric_type}\" AND resource.type=\"${var.alarm_configuration.resource_type}\" AND metadata.user_labels.md-package=\"${var.md_metadata.name_prefix}\""
}

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_resource_id = local.alarm_unique_id
}
