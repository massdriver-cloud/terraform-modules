resource "google_compute_global_address" "main" {
  name         = var.resource_name
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

resource "google_compute_managed_ssl_certificate" "main" {
  name = var.resource_name

  managed {
    domains = ["${var.subdomain}.${data.google_dns_managed_zone.main.dns_name}"]
  }
}

resource "google_compute_target_https_proxy" "main" {
  name             = var.resource_name
  url_map          = google_compute_url_map.main.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.main.id]
}

resource "google_compute_global_forwarding_rule" "main" {
  provider   = google-beta
  name       = var.resource_name
  labels     = var.lables
  target     = google_compute_target_https_proxy.main.self_link
  ip_address = google_compute_global_address.main.address
  port_range = "443"
  depends_on = [google_compute_global_address.main]
}

locals {
  # cloud_run_neg      =
  # cloud_function_neg =
  backend_group = var.cloud_run_service_name != null ? google_compute_region_network_endpoint_group.cloud_run[0].id : google_compute_region_network_endpoint_group.cloud_function[0].id
}

resource "google_compute_backend_service" "main" {
  name        = var.resource_name
  timeout_sec = 30

  backend {
    group = local.backend_group
  }
}

resource "google_compute_url_map" "main" {
  name            = var.resource_name
  default_service = google_compute_backend_service.main.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "all"
  }

  path_matcher {
    name            = "all"
    default_service = google_compute_backend_service.main.id
  }
}
