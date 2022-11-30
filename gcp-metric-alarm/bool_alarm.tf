resource "google_monitoring_alert_policy" "bool" {
  count        = var.alarm_configuration.value_type == "BOOL" ? 1 : 0
  display_name = local.alarm_unique_id
  combiner     = "OR"
  conditions {
    display_name = "${var.md_metadata.name_prefix} BOOL"
    condition_threshold {
      filter   = local.filter
      duration = "${var.alarm_configuration.duration_s}s"
      # only COMPARISON_LT and COMPARISON_GT are supported
      comparison = "COMPARISON_GT"
      # should be able to use for numbers too
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
