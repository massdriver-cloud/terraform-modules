locals {
  uuid            = lower(replace(var.display_name, " ", ""))
  alarm_unique_id = "${var.md_metadata.name_prefix}-${local.uuid}"
}

resource "google_monitoring_alert_policy" "main" {
  display_name = local.alarm_unique_id
  combiner     = "OR"
  conditions {
    display_name = "${var.md_metadata.name_prefix} COMPARISON_GT"
    condition_threshold {
      filter     = "metric.type=\"${var.alarm_configuration.metric_type}\" AND resource.type=\"${var.alarm_configuration.resource_type}\" AND metadata.user_labels.md-package=\"${var.md_metadata.name_prefix}\""
      duration   = "${var.alarm_configuration.duration_s}s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period     = "${var.alarm_configuration.alignment_period_s}s"
        cross_series_reducer = "REDUCE_MEAN"
        per_series_aligner   = "ALIGN_MAX"
      }
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

resource "massdriver_package_alarm" "package_alarm" {
  display_name      = var.display_name
  cloud_resource_id = local.alarm_unique_id
}
