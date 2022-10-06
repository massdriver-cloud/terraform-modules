module "endpoint" {
  count                   = var.endpoint.enabled ? 1 : 0
  source                  = "github.com/massdriver-cloud/terraform-modules//gcp-endpoint?ref=076ecd7"
  resource_name           = var.md_metadata.name_prefix
  labels                  = var.md_metadata.default_tags
  location                = var.location
  zone                    = var.endpoint.zone
  subdomain               = var.endpoint.subdomain
  managed_instance_groups = google_compute_instance_group_manager.main
  managed_instance_group_health_check = {
    port = var.health_check.port
    path = var.health_check.path
  }
}
