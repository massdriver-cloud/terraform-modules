resource "google_compute_autoscaler" "main" {
  for_each = toset(data.google_compute_zones.available.names)
  provider = google-beta

  name   = module.application.params.md_metadata.name_prefix
  zone   = each.value
  target = google_compute_instance_group_manager.main[each.value].id

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}
