resource "massdriver_package_alarm" "main" {
  cloud_resource_id = var.cloud_resource_id
  display_name      = var.display_name
  metric {
    name       = var.metric_name
    namespace  = var.metric_namespace
    statistic  = var.metric_statistic
    dimensions = var.metric_dimensions
  }
}
