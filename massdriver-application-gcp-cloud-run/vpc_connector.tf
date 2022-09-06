# This allows access from Cloud Run to your VPC
# for database / cache network access

resource "google_vpc_access_connector" "connector" {
  count          = var.vpc_connector_cidr == null ? 0 : 1
  name           = module.application.params.md_metadata.name_prefix
  provider       = google-beta
  region         = var.location
  ip_cidr_range  = var.vpc_connector_cidr
  max_throughput = 300
  network        = var.network
  depends_on = [
    module.apis
  ]
}
