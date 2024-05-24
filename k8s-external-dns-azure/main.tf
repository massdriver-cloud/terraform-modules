module "external-dns" {
  for_each           = { for zone in var.azure_dns_zones.dns_zones : zone => zone }
  source             = "../k8s-external-dns"
  md_metadata        = var.md_metadata
  kubernetes_cluster = var.kubernetes_cluster
  release            = regex("^[a-z0-9-]+", "${var.release}-${each.value}")
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
        secretName = kubernetes_secret.external_dns[each.key].metadata[0].name
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
