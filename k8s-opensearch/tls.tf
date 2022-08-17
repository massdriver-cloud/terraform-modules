
resource "tls_private_key" "opensearch" {
  count = true ? 1 : 0 # in the future we may opt to use cert-manager if it is installed in the cluster
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "opensearch" {
  count = true ? 1 : 0
  private_key_pem = tls_private_key.opensearch[0].private_key_pem
  subject {
    common_name  = "massdriver.cloud"
    organization = "MassDriver Inc"
  }
  validity_period_hours = 24 * 365 * 5 # 5 years
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
