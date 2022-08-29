module "serverless_endpoint" {
  count                  = var.endpoint != null ? 1 : 0
  source                 = "github.com/massdriver-cloud/terraform-modules//gcp-serverless-endpoint"
  rresource_name         = module.application.params.md_metadata.name_prefix
  zone                   = var.endpoint.zone
  subdomain              = var.endpoint.subdomain
  location               = var.location
  cloud_run_service_name = google_cloud_run_service.main.name
  depends_on = [
    module.apis
  ]
}
