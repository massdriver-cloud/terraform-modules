resource "massdriver_package_alarm" "main" {
  display_name      = var.display_name
  cloud_resource_id = "${var.md_metadata.name_prefix}_${var.prometheus_alert_name}"
}
