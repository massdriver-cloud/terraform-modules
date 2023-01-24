output "namespace" {
  value = kubernetes_namespace_v1.main
}

output "service_account" {
  value = kubernetes_service_account_v1.main
}

output "secret" {
  value     = kubernetes_secret_v1.main
  sensitive = true
}
