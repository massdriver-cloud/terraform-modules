locals {
  resource_suffix                  = "externaldns"
  max_length                       = 29
  external_dns_account_id_computed = join("-", flatten(slice(split("-", var.md_metadata.name_prefix), 2, 4)), [local.resource_suffix])
  external_dns_account_id          = substr(local.external_dns_account_id_computed, 0, local.max_length)

  resource_suffix_role = "externaldns"
  max_length_role      = 29
  # dashes are not allowed in custom role ids
  role_id_computed = replace(join("-", flatten(slice(split("-", var.md_metadata.name_prefix), 2, 4)), [local.resource_suffix_role]), "-", "")
  role_id          = substr(local.role_id_computed, 0, local.max_length_role)
}

resource "google_service_account" "external_dns" {
  account_id   = local.external_dns_account_id
  display_name = "The GCP service account responsible for external-dns"
}

resource "google_project_iam_member" "gcp_sa" {
  project = var.gcp_project_id
  role    = "roles/dns.admin"
  members = [
    "serviceAccount:${google_service_account.external_dns.email}"
  ]
}

# we use *_member because *_binding is authoratative for a role
# which means that if we bind w/ the workload identity role
# cert-mananger and external-dns fight for sole ownership/assignment of that role
resource "google_project_iam_member" "k8s_sa" {
  project = var.gcp_project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.gcp_project_id}.svc.id.goog[${var.namespace}/${local.service_account_name}]"
}
