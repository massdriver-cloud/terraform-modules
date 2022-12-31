output "kubernetes_token" {
  value     = lookup(kubernetes_secret_v1.main.data, "token")
  sensitive = true
}
