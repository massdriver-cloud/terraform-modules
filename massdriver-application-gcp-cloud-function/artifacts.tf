locals {
  data_infrastructure = {
    function_url = google_cloudfunctions_function.main.https_trigger_url
    name         = google_cloudfunctions_function.main.name
  }
  data_security = {
  }

  artifact_cloud_function = {
    data = {
      infrastructure = local.data_infrastructure
      security       = local.data_security
    }
    specs = {
      gcp = {
        project = google_cloudfunctions_function.main.project
        region  = google_cloudfunctions_function.main.region
      }
    }
  }
}

resource "massdriver_artifact" "cloud_function" {
  field                = "cloud_function"
  provider_resource_id = google_cloudfunctions_function.main.id
  name                 = "GCP Cloud Function ${var.name} (${google_cloudfunctions_function.main.id})"
  artifact             = jsonencode(local.artifact_cloud_function)
}
