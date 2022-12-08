locals {
  from_cidrs = compact([for subnet in data.google_compute_subnetwork.lookup : subnet.ip_cidr_range])
  # subnets = compact([for subnet in data.google_compute_subnetwork.lookup : (subnet.ip_cidr_range == null ? null : subnet)])
  # used_cidrs = compact([for subnet in data.google_compute_subnetwork.lookup : subnet.secondary_ip_range == null ? null : compact([for range in subnet.secondary_ip_range : range.ip_cidr_range])])
  # used_cidrs = compact([for range in local.secondary_ranges : range.ip_cidr_range])
}

data "google_compute_network" "main" {
  name    = var.virtual_network_name
  project = "md-demos"
}

data "google_compute_subnetwork" "lookup" {
  for_each  = toset(data.google_compute_network.main.subnetworks_self_links)
  self_link = each.key
}

# output "subnets" {
#   value = data.google_compute_network.main
# }

resource "utility_available_cidr" "main" {
  from_cidrs = local.from_cidrs
  used_cidrs = ["10.208.0.0/16", "10.209.0.0/20"]
  mask       = 16
}
