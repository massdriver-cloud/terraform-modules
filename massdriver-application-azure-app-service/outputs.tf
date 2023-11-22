output "identity" {
  description = "Cloud ID for application IAM. For Azure this is the Managed Identity ID."
  value       = module.application.identity
}

output "resource_id" {
  description = "Cloud Resource ID for the resource"
  value       = azurerm_linux_web_app.main.id
}

output "hostname" {
  description = "Default hostname for the application runtime"
  value       = azurerm_linux_web_app.main.default_hostname
}
