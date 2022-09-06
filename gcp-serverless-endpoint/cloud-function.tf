resource "google_compute_region_network_endpoint_group" "cloud_function" {
  count                 = var.cloud_function_service_name != null ? 1 : 0
  name                  = var.resource_name
  network_endpoint_type = "SERVERLESS"
  region                = var.location
  cloud_function {
    function = var.cloud_function_service_name
  }
}
