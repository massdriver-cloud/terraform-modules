resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = var.alarm_name
  combiner     = "OR"
  conditions {
    display_name = "${var.alarm_name} COMPARISON_GT"
    condition_threshold {
      filter     = "metric.type=\"${var.metric_type}\" AND resource.type=\"${var.resource_type}\" AND metadata.user_labels.md-package=\"${var.md_metadata.name_prefix}\""
      duration   = "${var.duration}s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period     = "${var.period}s"
        cross_series_reducer = "REDUCE_MEAN"
        per_series_aligner   = "ALIGN_MAX"
      }
      threshold_value = var.threshold

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

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_provider_id = google_monitoring_alert_policy.alert_policy.name
}
