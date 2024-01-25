module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=d1393a8"
  name    = var.md_metadata.name_prefix
  service = "vm"
}

# TODO: push to mdxc for gcp vms?
# NOTE: assumes registry is in the same project as the application
data "google_project" "main" {
}

resource "google_project_iam_member" "containers" {
  project = data.google_project.main.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${module.application.identity}"
}

resource "google_compute_instance_template" "main" {
  # checkov:skip=CKV_GCP_39: ADD REASON
  provider = google-beta

  name_prefix  = var.md_metadata.name_prefix
  labels       = var.md_metadata.default_tags
  machine_type = var.machine_type

  can_ip_forward = false

  # network tags
  tags = [var.md_metadata.name_prefix]

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  disk {
    source_image = data.google_compute_image.main.id
  }

  network_interface {
    network    = var.subnetwork.data.infrastructure.gcp_global_network_grn
    subnetwork = var.subnetwork.data.infrastructure.grn
  }

  metadata = {
    block-project-ssh-keys = true
    # DISCLAIMER:
    # This container declaration format is not a public API and may change without
    # notice. Please use gcloud command-line tool or Google Cloud Console to run
    # Containers on Google Compute Engine.
    gce-container-declaration = yamlencode({
      "spec" : {
        "containers" : [
          {
            "image" : var.container_image,
            "env" : [for key, val in module.application.envs :
              {
                "name" : key,
                "value" : val,
            }]
            "name" : var.md_metadata.name_prefix,
            "securityContext" : {
              "privileged" : false
            },
            "stdin" : false,
            "tty" : false,
            "volumeMounts" : [],
          },
        ],
        "restartPolicy" : "Always",
        "volumes" : []
      }
    })
    google-logging-enabled = "true"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["cloud-platform"]
    email  = module.application.identity
  }

  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template#automatic_restart
  scheduling {
    # Spot Instances are the "new" preemptible, but it means the same thing.
    # To use spot,
    #   + auto_restart must be turned off (false)
    #   + preemptible must be set to true
    #   + provisioning_model must be set to spot

    # this could be shortened to
    # preemptible = var.spot_instances_enabled
    # but it was done this way to make it easier to read
    preemptible        = var.spot_instances_enabled ? true : false
    automatic_restart  = var.spot_instances_enabled ? false : true
    provisioning_model = var.spot_instances_enabled ? "SPOT" : "STANDARD"
  }

  # We need the new template to be created before the old one is deleted.
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_target_pool" "main" {
  provider = google-beta
  name     = var.md_metadata.name_prefix
  region   = var.location
}

data "google_compute_zones" "available" {
  region = var.location
}

resource "google_compute_instance_group_manager" "main" {
  for_each = toset(data.google_compute_zones.available.names)
  provider = google-beta

  name = var.md_metadata.name_prefix
  # regional
  zone = each.value

  version {
    instance_template = google_compute_instance_template.main.self_link
    name              = "primary"
  }

  named_port {
    name = "http"
    port = var.port
  }

  target_pools       = [google_compute_target_pool.main.id]
  base_instance_name = var.md_metadata.name_prefix

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

locals {
  compute_image_family_to_project = {
    "cos-101-lts"  = "cos-cloud"
    "common-cu110" = "deeplearning-platform-release"
  }
}

data "google_compute_image" "main" {
  provider = google-beta

  family  = var.compute_image_family
  project = local.compute_image_family_to_project[var.compute_image_family]
}

resource "google_compute_firewall" "main" {
  name    = var.md_metadata.name_prefix
  network = var.subnetwork.data.infrastructure.gcp_global_network_grn

  allow {
    protocol = "tcp"
    ports    = [tostring(var.port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.md_metadata.name_prefix]
}
