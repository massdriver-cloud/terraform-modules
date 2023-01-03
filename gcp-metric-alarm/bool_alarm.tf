resource "google_monitoring_alert_policy" "bool" {
  count        = var.alarm_configuration.value_type == "BOOL" ? 1 : 0
  display_name = local.alarm_id
  combiner     = "OR"
  conditions {
    display_name = var.display_name
    condition_threshold {
      filter   = local.filter
      duration = "${var.alarm_configuration.duration_s}s"
      # only COMPARISON_LT and COMPARISON_GT are supported
      comparison = "COMPARISON_GT"
      # bool alarms are 0 or 1
      threshold_value = var.alarm_configuration.threshold

      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    var.notification_channel_id
  ]

  user_labels = var.md_metadata.default_tags
}
