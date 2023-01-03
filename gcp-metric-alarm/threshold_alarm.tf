locals {
  is_theshold_alarm = var.alarm_configuration.value_type == "DOUBLE" || var.alarm_configuration.value_type == "INT64"
}

resource "google_monitoring_alert_policy" "main" {
  count        = local.is_theshold_alarm ? 1 : 0
  display_name = local.alarm_id
  combiner     = "OR"
  conditions {
    display_name = var.display_name
    condition_threshold {
      filter     = local.filter
      duration   = "${var.alarm_configuration.duration_s}s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period     = "${var.alarm_configuration.alignment_period_s}s"
        cross_series_reducer = "REDUCE_MEAN"
        per_series_aligner   = "ALIGN_MAX"
      }
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
