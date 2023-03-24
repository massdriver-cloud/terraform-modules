resource "mongodbatlas_cloud_backup_schedule" "main" {
  count        = var.backup_enabled ? 1 : 0
  project_id   = mongodbatlas_advanced_cluster.main.project_id
  cluster_name = mongodbatlas_advanced_cluster.main.name

  dynamic "policy_item_hourly" {
    for_each = [for element in var.backup_schedule : element if element.frequency_type == "hourly"]
    content {
      frequency_interval = policy_item_hourly.value.frequency_interval
      retention_unit     = policy_item_hourly.value.retention_unit
      retention_value    = policy_item_hourly.value.retention_value
    }
  }

  dynamic "policy_item_daily" {
    for_each = [for element in var.backup_schedule : element if element.frequency_type == "daily"]
    content {
      frequency_interval = policy_item_daily.value.frequency_interval
      retention_unit     = policy_item_daily.value.retention_unit
      retention_value    = policy_item_daily.value.retention_value
    }
  }

  dynamic "policy_item_weekly" {
    for_each = [for element in var.backup_schedule : element if element.frequency_type == "weekly"]
    content {
      frequency_interval = policy_item_weekly.value.frequency_interval
      retention_unit     = policy_item_weekly.value.retention_unit
      retention_value    = policy_item_weekly.value.retention_value
    }
  }

  dynamic "policy_item_monthly" {
    for_each = [for element in var.backup_schedule : element if element.frequency_type == "monthly"]
    content {
      frequency_interval = policy_item_monthly.value.frequency_interval
      retention_unit     = policy_item_monthly.value.retention_unit
      retention_value    = policy_item_monthly.value.retention_value
    }
  }
}
