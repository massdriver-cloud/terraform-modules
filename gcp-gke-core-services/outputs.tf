
resource "time_sleep" "wait_for_secret_token" {
  depends_on      = [kubernetes_secret_v1.massdriver-cloud-provisioner_token]
  create_duration = "10s"
}

output "kubernetes_token" {
  value      = lookup(kubernetes_secret_v1.massdriver-cloud-provisioner_token.data, "token")
  sensitive  = true
  depends_on = [time_sleep.wait_for_secret_token]
}
