module "external-dns" {
  source             = "../k8s-external-dns"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  domain_filters     = local.domain_filters
  helm_additional_values = {
    extraVolumes = [{
      name = "azure-config-file"
      secret = {
        secretName = kubernetes_secret.external_dns.metadata[0].name
        items = [{
          key  = "azure.json"
          path = "azure.json"
        }]
      }
    }]
    extraVolumeMounts = [{
      name      = "azure-config-file"
      mountPath = "/etc/kubernetes"
      readOnly  = true
    }]
  }
  dns_provider = "azure"
}
