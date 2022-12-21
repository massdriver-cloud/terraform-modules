locals {
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
  cluster_token          = data.google_client_config.provider.access_token
  cluster_host           = "https://${data.google_container_cluster.cluster.endpoint}"
  cluster_name           = var.md_metadata.name_prefix
  cluster_network_tag    = "gke-${local.cluster_name}"
}
