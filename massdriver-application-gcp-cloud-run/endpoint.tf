module "serverless_endpoint" {
  count                  = var.endpoint != null ? 1 : 0
  source                 = "github.com/massdriver-cloud/terraform-modules//gcp-serverless-endpoint?ref=8c4cd0b"
  resource_name          = module.application.params.md_metadata.name_prefix
  labels                 = module.application.params.md_metadata.default_tags
  zone                   = var.endpoint.zone
  subdomain              = var.endpoint.subdomain
  location               = var.location
  cloud_run_service_name = google_cloud_run_service.main.name
  depends_on = [
    module.apis
  ]
}
