locals {
  enable_cert_manager = length(var.cloud_dns_managed_zones) > 0
  enable_external_dns = length(var.cloud_dns_managed_zones) > 0

  cloud_dns_managed_zones_to_domain_map = {
    for zone in local.managed_zones :
    zone => data.google_dns_managed_zone.hosted_zones[zone].dns_name
  }
  core_services_namespace = "md-core-services"

  managed_zones = [for zone in var.cloud_dns_managed_zones :
    length(split("/", zone)) > 1 ? split("/", zone)[3] : zone
  ]
}

data "google_dns_managed_zone" "hosted_zones" {
  for_each = toset(local.managed_zones)
  name     = each.key
}

module "ingress_nginx" {
  source             = "github.com/massdriver-cloud/terraform-modules//k8s-ingress-nginx?ref=00807b3"
  count              = var.enable_ingress ? 1 : 0
  kubernetes_cluster = var.kubernetes_cluster_artifact
  md_metadata        = var.md_metadata
  release            = "ingress-nginx"
  namespace          = kubernetes_namespace_v1.md-core-services.metadata.0.name
}

module "external_dns" {
  source                  = "github.com/massdriver-cloud/terraform-modules//k8s-external-dns-gcp?ref=00807b3"
  count                   = local.enable_external_dns ? 1 : 0
  kubernetes_cluster      = var.kubernetes_cluster_artifact
  md_metadata             = var.md_metadata
  release                 = "external-dns"
  namespace               = kubernetes_namespace_v1.md-core-services.metadata.0.name
  cloud_dns_managed_zones = local.cloud_dns_managed_zones_to_domain_map
  gcp_project_id          = var.gcp_config.project_id
}

module "cert_manager" {
  source             = "github.com/massdriver-cloud/terraform-modules//k8s-cert-manager-gcp?ref=00807b3"
  count              = local.enable_cert_manager ? 1 : 0
  kubernetes_cluster = var.kubernetes_cluster_artifact
  md_metadata        = var.md_metadata
  release            = "cert-manager"
  namespace          = kubernetes_namespace_v1.md-core-services.metadata.0.name
  gcp_project_id     = var.gcp_config.project_id
}
