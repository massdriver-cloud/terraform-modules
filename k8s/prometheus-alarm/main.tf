# Massdriver builds the ID of a firing Alertmanager alert from its md_instance (or legacy
# md_package) label and alertname.
resource "massdriver_instance_alarm" "main" {
  display_name      = var.display_name
  cloud_resource_id = "${try(var.md_metadata.default_tags["md-instance"], var.md_metadata.default_tags["md-package"])}_${var.prometheus_alert_name}"
}
