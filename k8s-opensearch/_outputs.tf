output "service_url" {
  value = "https://opensearch-cluster-master.${var.namespace}.svc.cluster.local:9200"
}

output "dashboards_url" {
  value = var.enable_dashboards ? "https://${local.dashboards.release_name}.${var.namespace}.svc.cluster.local:5601" : ""
}
