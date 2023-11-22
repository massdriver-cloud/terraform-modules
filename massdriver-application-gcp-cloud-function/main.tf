module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=61a38e9"
  name    = var.md_metadata.name_prefix
  service = "function"
}

resource "google_cloudfunctions_function" "main" {
  name                          = var.md_metadata.name_prefix
  service_account_email         = module.application.identity
  labels                        = var.md_metadata.default_tags
  region                        = var.location
  runtime                       = var.cloud_function_configuration.runtime
  environment_variables         = module.application.envs
  trigger_http                  = true
  entry_point                   = var.cloud_function_configuration.entrypoint
  available_memory_mb           = var.cloud_function_configuration.memory_mb
  min_instances                 = var.cloud_function_configuration.minimum_instances
  max_instances                 = var.cloud_function_configuration.maximum_instances
  source_archive_bucket         = google_storage_bucket.main.name
  source_archive_object         = var.source_archive_path
  ingress_settings              = "ALLOW_INTERNAL_AND_GCLB"
  vpc_connector                 = var.vpc_connector
  vpc_connector_egress_settings = "PRIVATE_RANGES_ONLY"

  # default: 60  (s)
  # max    : 540 (s)
  timeout = 120

  # TODO: https://github.com/massdriver-cloud/massdriver/issues/1495
  # docker_registry   = "ARTIFACT_REGISTRY"
  # docker_repository = "projects/<>/locations/us-west2/repositories/<>"

  depends_on = [
    module.apis
  ]
}
