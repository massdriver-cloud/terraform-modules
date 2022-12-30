data "google_compute_network" "main" {
  name = var.network_name
}

data "google_compute_subnetwork" "lookup" {
  for_each = toset(data.google_compute_network.main.subnetworks_self_links)
  self_link = each.key
}

locals {
  from_cidrs = ["10.0.0.0/8"]
  subnet_map = flatten([
    for subnet in data.google_compute_subnetwork.lookup : [subnet.id == null ? null : subnet]
  ])
  used_cidrs = compact(flatten([for subnet in local.subnet_map : [subnet == null ? null : subnet.ip_cidr_range]]))
}

resource "utility_available_cidr" "main" {
  from_cidrs = local.from_cidrs
  used_cidrs = local.used_cidrs
  mask       = var.cidr_mask
}
