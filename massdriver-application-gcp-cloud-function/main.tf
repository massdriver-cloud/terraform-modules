module "application" {
  source = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  // um wut, should be var.name, but this does work...
  name    = var.name
  service = "function"
}

resource "google_cloudfunctions_function" "main" {
  name                  = module.application.params.md_metadata.name_prefix
  labels                = module.application.params.md_metadata.default_tags
  runtime               = var.runtime
  trigger_http          = true
  entry_point           = var.cloud_function_configuration.entrypoint
  available_memory_mb   = var.cloud_function_configuration.memory_mb
  min_instances         = var.cloud_function_configuration.minimum_instances
  max_instances         = var.cloud_function_configuration.maximum_instances
  source_archive_bucket = var.source_archive.bucket
  source_archive_object = var.source_archive.object

  # default: 60  (s)
  # max    : 540 (s)
  timeout = 120

  depends_on = [
    module.apis
  ]
}


