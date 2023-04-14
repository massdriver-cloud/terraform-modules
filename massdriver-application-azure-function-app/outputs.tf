output "id" {
  description = "Cloud ID for application IAM (AWS Role, GCP Service Account, Azure Managed Identity ID, etc)"
  value       = module.application.id
}

output "resource_id" {
  description = "Cloud Resource ID for the resource"
  value       = azurerm_linux_function_app.main.id
}

output "hostname" {
  description = "Default hostname for the application runtime"
  value       = azurerm_linux_function_app.main.default_hostname
}
