locals {
  # Legacy default tags have no md-instance, only md-package (the name_prefix).
  instance_label = can(var.md_metadata.default_tags["md-instance"]) ? "md-instance" : "md-package"
  filter         = "metric.type=\"${var.alarm_configuration.metric_type}\" AND resource.type=\"${var.alarm_configuration.resource_type}\" AND metadata.user_labels.${local.instance_label}=\"${var.md_metadata.default_tags[local.instance_label]}\""
  # this is used as the _required_ argument `display_name`, which is essentially the GUID for the alarm.
  # packages can have multiple alarms of each type, so we need more than the name_prefix here
  alarm_id = "${var.md_metadata.name_prefix}-${lower(replace(var.display_name, " ", ""))}"
}

resource "massdriver_instance_alarm" "instance_alarm" {
  display_name      = var.display_name
  cloud_resource_id = var.cloud_resource_id
  metric {
    namespace = var.alarm_configuration.resource_type
    name      = var.alarm_configuration.metric_type
  }
}
