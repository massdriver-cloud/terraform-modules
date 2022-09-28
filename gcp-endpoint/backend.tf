locals {
  backend_group = compact([
    var.cloud_run_service_name != null ? google_compute_region_network_endpoint_group.cloud_run[0].id : null,
    var.cloud_function_service_name != null ? google_compute_region_network_endpoint_group.cloud_function[0].id : null
  ])
  is_serverless = var.cloud_run_service_name != null || var.cloud_function_service_name != null
  health_checks = local.is_serverless ? null : [google_compute_health_check.mig[0].id]
}

resource "google_compute_backend_service" "main" {
  name        = var.resource_name
  timeout_sec = 30

  dynamic "backend" {
    for_each = var.managed_instance_groups == null ? {} : var.managed_instance_groups
    content {
      group = backend.value.instance_group
    }
  }

  dynamic "backend" {
    for_each = local.is_serverless ? [true] : []
    content {
      group = local.backend_group[0]
    }
  }

  health_checks = local.health_checks
}

resource "google_compute_health_check" "mig" {
  count               = local.is_serverless ? 0 : 1
  name                = var.resource_name
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = var.managed_instance_group_health_check.path
    port         = var.managed_instance_group_health_check.port
  }
}
