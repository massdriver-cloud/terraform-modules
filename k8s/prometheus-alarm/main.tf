# Massdriver builds the ID of a firing Alertmanager alert from its md_instance label and alertname.
resource "massdriver_package_alarm" "main" {
  display_name      = var.display_name
  cloud_resource_id = "${var.md_metadata.default_tags["md-instance"]}_${var.prometheus_alert_name}"
}
