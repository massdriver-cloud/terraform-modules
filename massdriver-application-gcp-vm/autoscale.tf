resource "google_compute_autoscaler" "main" {
  provider = google-beta

  name   = module.application.params.md_metadata.name_prefix
  zone   = data.google_compute_zones.available.names[0]
  target = google_compute_instance_group_manager.main.id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}
