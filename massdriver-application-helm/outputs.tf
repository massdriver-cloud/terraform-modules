output "identity" {
  description = "Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity ID, etc)"
  value       = module.application.id
}

output "secrets" {
  description = "Secrets from the bundle configuration"
  value       = module.application.secrets
}
