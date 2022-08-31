locals {
  managed_zone_name = length(split("/", var.zone)) > 1 ? split("/", var.zone)[3] : var.zone
}

data "google_dns_managed_zone" "main" {
  name = local.managed_zone_name
}

resource "google_dns_record_set" "set" {
  name         = "${var.subdomain}.${data.google_dns_managed_zone.main.dns_name}"
  type         = "A"
  ttl          = 3600
  managed_zone = data.google_dns_managed_zone.main.name
  rrdatas      = [google_compute_global_forwarding_rule.main.ip_address]
}
