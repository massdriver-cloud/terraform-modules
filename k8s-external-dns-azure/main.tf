module "external-dns" {
  source             = "../k8s-external-dns"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = var.release
  namespace          = var.namespace
  domain_filters     = local.domain_filters
  helm_additional_values = {
    podLabels = {
      "azure.workload.identity/use" = "true"
    }
    serviceAccount = {
      labels = {
        "azure.workload.identity/use" = "true"
      }
      annotations = {
        "azure.workload.identity/client-id" = azurerm_user_assigned_identity.external_dns.client_id
      }
    }
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
