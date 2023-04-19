output "identity" {
  description = "Cloud ID for application IAM. For Azure this is the Managed Identity ID."
  value       = module.application.id
}
