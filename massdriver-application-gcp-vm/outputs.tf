output "identity" {
  description = "Cloud ID for application IAM. For GCP this is the Service Account email."
  value       = module.application.identity
}
