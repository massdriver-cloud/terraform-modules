locals {
  # come up with a better name for this
  resource_suffix                  = "certmanager"
  max_length                       = 29
  cert_manager_account_id_computed = join("-", flatten(slice(split("-", var.md_metadata.name_prefix), 2, 4)), [local.resource_suffix])
  cert_manager_account_id          = substr(local.cert_manager_account_id_computed, 0, local.max_length)

  resource_suffix_role = "certmanager"
  max_length_role      = 29
  # dashes are not allowed in custom role ids
  role_id_computed = replace(join("-", flatten(slice(split("-", var.md_metadata.name_prefix), 2, 4)), [local.resource_suffix_role]), "-", "")
  role_id          = substr(local.role_id_computed, 0, local.max_length_role)

  service_account_name = var.release == "cert-manager" ? "cert-manager" : "${var.release}-cert-manager"
}

resource "google_service_account" "dns_admin" {
  account_id   = local.cert_manager_account_id
  display_name = "Service Account to be used with cert-manager to verify the domain"
}

resource "google_project_iam_custom_role" "dns_least_privilege" {
  role_id     = local.role_id
  title       = "Least Privilege DNS for Cert Manager"
  description = "Custom role for use with cert-manager to manage domain verification"
  permissions = [
    "dns.resourceRecordSets.create",
    "dns.resourceRecordSets.delete",
    "dns.resourceRecordSets.get",
    "dns.resourceRecordSets.list",
    "dns.resourceRecordSets.update",
    "dns.changes.create",
    "dns.changes.get",
    "dns.changes.list",
    "dns.managedZones.list"
  ]
}

# here we can use a binding since this will be the only custom role
# of this kind, each is unique to the module, project
resource "google_project_iam_binding" "gcp_sa" {
  project = var.gcp_project_id
  role    = google_project_iam_custom_role.dns_least_privilege.id
  members = [
    "serviceAccount:${google_service_account.dns_admin.email}"
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
