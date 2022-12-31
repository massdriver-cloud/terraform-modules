output "kubernetes_token" {
  value     = lookup(data.kubernetes_secret.massdriver-cloud-provisioner_service-account_secret.data, "token")
  sensitive = true
}
