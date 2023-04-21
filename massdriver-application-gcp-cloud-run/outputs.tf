output "id" {
  description = "The massdriver-application specification."
  value       = module.application.id
}

output "hostname" {
  value = google_cloud_run_service.main.status.0.url
}
