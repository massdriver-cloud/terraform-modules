module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = module.application.params.md_metadata.name_prefix
  service = "vm"
}

# TODO: push to mdxc for gcp vms?
# NOTE: assumes registry is in the same project as the application
data "google_project" "main" {
}

resource "google_project_iam_member" "containers" {
  project = data.google_project.main.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${module.application.id}"
}

resource "google_compute_instance_template" "main" {
  # checkov:skip=CKV_GCP_39: ADD REASON
  provider = google-beta

  name_prefix  = module.application.params.md_metadata.name_prefix
  labels       = module.application.params.md_metadata.default_tags
  machine_type = var.machine_type

  can_ip_forward = false

  # network tags
  tags = [module.application.params.md_metadata.name_prefix]

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
            "name" : module.application.params.md_metadata.name_prefix,
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
    email  = module.application.id
  }

  # We need the new template to be created before the old one is deleted.
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_target_pool" "main" {
  provider = google-beta
  name     = module.application.params.md_metadata.name_prefix
  region   = var.location
}

data "google_compute_zones" "available" {
  region = var.location
}

resource "google_compute_instance_group_manager" "main" {
  for_each = toset(data.google_compute_zones.available.names)
  provider = google-beta

  name = module.application.params.md_metadata.name_prefix
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
  base_instance_name = module.application.params.md_metadata.name_prefix

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

data "google_compute_image" "main" {
  provider = google-beta

  family  = "cos-101-lts"
  project = "cos-cloud"
}

resource "google_compute_firewall" "main" {
  name    = module.application.params.md_metadata.name_prefix
  network = var.subnetwork.data.infrastructure.gcp_global_network_grn

  allow {
    protocol = "tcp"
    ports    = [tostring(var.port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [module.application.params.md_metadata.name_prefix]
}
