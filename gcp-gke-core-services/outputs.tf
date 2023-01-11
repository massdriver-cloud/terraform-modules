output "kubernetes_token" {
  value     = lookup(module.core_services_service_account.secret.data, "token")
  sensitive = true
}
