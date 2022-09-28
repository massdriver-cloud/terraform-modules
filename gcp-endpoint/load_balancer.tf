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

resource "google_compute_target_http_proxy" "main" {
  name    = var.resource_name
  url_map = google_compute_url_map.https_redirect.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  provider   = google-beta
  name       = var.resource_name
  labels     = var.labels
  target     = google_compute_target_http_proxy.main.self_link
  ip_address = google_compute_global_address.main.address
  port_range = "80"
  depends_on = [google_compute_global_address.main]
}

resource "google_compute_global_forwarding_rule" "https" {
  provider   = google-beta
  name       = "${var.resource_name}-https"
  labels     = var.labels
  target     = google_compute_target_https_proxy.main.self_link
  ip_address = google_compute_global_address.main.address
  port_range = "443"
  depends_on = [google_compute_global_address.main]
}

resource "google_compute_url_map" "main" {
  name            = "${var.resource_name}-https"
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

resource "google_compute_url_map" "https_redirect" {
  name = "${var.resource_name}-redirect"
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}
