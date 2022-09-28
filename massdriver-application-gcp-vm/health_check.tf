resource "google_compute_health_check" "autohealing" {
  name                = "${module.application.params.md_metadata.name_prefix}-vm-hcheck"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}
