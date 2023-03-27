output "identity" {
  description = "The massdriver-application IAM entity id (AWS Role ARN, GCP Service Account email, Azure Principal ID)."
  value       = module.application.id
}
