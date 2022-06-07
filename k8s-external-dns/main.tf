locals {
  # k8s this should be the default calculated name anyway, but we want to enforce it just to be sure
  service_account_name = var.release == "external-dns" ? "external-dns" : "${var.release}-external-dns"

  helm_values = {
    serviceAccount = {
      name = local.service_account_name
    }
    domainFilters    = [var.domain_filters]
    provider         = var.dns_provider # https://github.com/kubernetes-sigs/external-dns/blob/5806e3474f2e13254498bd2af34302a4e283ae39/.github/labeler.yml
    additionalLabels = var.md_metadata.default_tags
  }
}

resource "helm_release" "external-dns" {
  name             = var.release
  chart            = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  version          = "1.7.1"
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode(var.helm_additional_values)
  ]
}
