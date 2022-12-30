locals {
  enable_cert_manager = length(var.core_services.cloud_dns_managed_zones) > 0
  enable_external_dns = length(var.core_services.cloud_dns_managed_zones) > 0

  cloud_dns_managed_zones_to_domain_map = {
    for zone in local.managed_zones :
    zone => data.google_dns_managed_zone.hosted_zones[zone].dns_name
  }
  core_services_namespace = "md-core-services"

  managed_zones = [for zone in var.core_services.cloud_dns_managed_zones :
    length(split("/", zone)) > 1 ? split("/", zone)[3] : zone
  ]
}

data "google_dns_managed_zone" "hosted_zones" {
  for_each = toset(local.managed_zones)
  name     = each.key
}

/******************************************
  Webhooks/Admission Controllers deployed to the GKE cluster,
  get called from the control plane. If the cluster has private _nodes_
  and if a webhook, etc.. get deployed to those nodes, this firewall rule is needed.
  Without this, things like cert-manager (double check) won't work
  https://github.com/kubernetes/kubernetes/issues/79739
 *****************************************/
resource "google_compute_firewall" "control_plane_ingress" {
  name        = "${var.md_metadata.name_prefix}-ingress"
  description = "Allow GKE control plane to hit pods for admission controllers/webhooks"
  project     = var.gcp_authentication.data.project_id
  network     = var.subnetwork.data.infrastructure.gcp_global_network_grn
  priority    = 1000
  direction   = "INGRESS"

  source_ranges = [var.cluster_networking.master_ipv4_cidr_block]
  source_tags   = []
  target_tags   = [local.cluster_network_tag]

  allow {
    protocol = "tcp"
    ports    = [8443]
  }
}

module "ingress_nginx" {
  source             = "github.com/massdriver-cloud/terraform-modules//k8s-ingress-nginx?ref=c336d59"
  count              = var.core_services.enable_ingress ? 1 : 0
  kubernetes_cluster = local.kubernetes_cluster_artifact
  md_metadata        = var.md_metadata
  release            = "ingress-nginx"
  namespace          = local.core_services_namespace
}

module "external_dns" {
  source                  = "github.com/massdriver-cloud/terraform-modules//k8s-external-dns-gcp?ref=64b906f"
  count                   = local.enable_external_dns ? 1 : 0
  kubernetes_cluster      = local.kubernetes_cluster_artifact
  md_metadata             = var.md_metadata
  release                 = "external-dns"
  namespace               = local.core_services_namespace
  cloud_dns_managed_zones = local.cloud_dns_managed_zones_to_domain_map
  gcp_project_id          = var.gcp_authentication.data.project_id
}

module "cert_manager" {
  source             = "github.com/massdriver-cloud/terraform-modules//k8s-cert-manager-gcp?ref=c336d59"
  count              = local.enable_cert_manager ? 1 : 0
  kubernetes_cluster = local.kubernetes_cluster_artifact
  md_metadata        = var.md_metadata
  release            = "cert-manager"
  namespace          = local.core_services_namespace
  gcp_project_id     = var.gcp_authentication.data.project_id
}
