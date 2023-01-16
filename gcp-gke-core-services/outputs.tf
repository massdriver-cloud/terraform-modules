
output "kubernetes_token" {
  value     = lookup(data.kubernetes_secret_v1.massdriver-cloud-provisioner_token.data, "token")
  sensitive = true
}
