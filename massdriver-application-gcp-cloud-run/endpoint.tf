module "serverless_endpoint" {
  count                  = (var.zone != null && var.subdomain != null) ? 1 : 0
  source                 = "github.com/massdriver-cloud/terraform-modules//gcp-serverless-endpoint?ref=a3371df"
  resource_name          = module.application.params.md_metadata.name_prefix
  labels                 = module.application.params.md_metadata.default_tags
  zone                   = var.zone
  subdomain              = var.subdomain
  location               = var.location
  cloud_run_service_name = google_cloud_run_service.main.name
  depends_on = [
    module.apis
  ]
}
