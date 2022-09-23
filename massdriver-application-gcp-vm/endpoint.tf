module "endpoint" {
  count                       = var.endpoint.enabled ? 1 : 0
  source                      = "../gcp-serverless-endpoint"
  resource_name               = module.application.params.md_metadata.name_prefix
  labels                      = module.application.params.md_metadata.default_tags
  location                    = var.location
  zone                        = var.endpoint.zone
  subdomain                   = var.endpoint.subdomain
  managed_instance_group_name = google_compute_instance_group_manager.main.instance_group
}
