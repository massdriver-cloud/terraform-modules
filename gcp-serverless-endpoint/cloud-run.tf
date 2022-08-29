# missing piece to cloud run DNS!
resource "google_compute_region_network_endpoint_group" "cloud_run" {
  count                 = var.cloud_run_service_name != null ? 1 : 0
  name                  = var.resource_name
  network_endpoint_type = "SERVERLESS"
  region                = var.location
  cloud_run {
    service = var.cloud_run_service_name
  }
}
