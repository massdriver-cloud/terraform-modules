variable "md_metadata" {
  description = "Massdriver package metadata object"
  type        = any
}

module "apis" {
  source   = "github.com/massdriver-cloud/terraform-modules//gcp-enable-apis?ref=c46bc59"
  services = ["monitoring.googleapis.com"]
}

resource "google_monitoring_notification_channel" "main" {
  depends_on   = [module.apis]
  display_name = "${var.md_metadata.name_prefix}-alarms"

  type = "webhook_tokenauth"
  labels = {
    url = var.md_metadata.observability.alarm_webhook_url
  }
  user_labels = {
    md-package = var.md_metadata.name_prefix
  }
}

output "id" {
  description = "Alarm Channel Monitoring Notification Channel ID"
  value       = google_monitoring_notification_channel.main.id
}
