
output "kubernetes_token" {
  value     = lookup(kubernetes_secret_v1.massdriver-cloud-provisioner_token.data, "token")
  sensitive = true
}
