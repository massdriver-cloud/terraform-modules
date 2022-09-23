module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = module.application.params.md_metadata.name_prefix
  service = "function"
}

resource "google_compute_instance_template" "main" {
  # checkov:skip=CKV_GCP_39: ADD REASON
  provider = google-beta

  name         = "${module.application.params.md_metadata.name_prefix}2"
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
    # gce-service-proxy      = <<-EOF
    # {
    #   "api-version": "0.2",
    #   "proxy-spec": {
    #     "proxy-port": 15001,
    #     "network": "my-network",
    #     "tracing": "ON",
    #     "access-log": "/var/log/envoy/access.log"
    #   }
    #   "service": {
    #     "serving-ports": [80, 81]
    #   },
    #  "labels": {
    #    "app_name": "bookserver_app",
    #    "app_version": "STABLE"
    #   }
    # }
    # EOF
    # DISCLAIMER:\n# This container declaration format is not a public API and may change without\n# notice. Please use gcloud command-line tool or Google Cloud Console to run\n# Containers on Google Compute Engine.\n\nspec:\n  containers:\n  - args:\n    - arg.sh\n    command:\n    - cmd.sh\n    image: nginxdemos/hello\n    name: from-cli-2\n    securityContext:\n      privileged: false\n    stdin: false\n    tty: false\n    volumeMounts: []\n  restartPolicy: Always\n  volumes: []\n
    gce-container-declaration = <<-EOF
      # DISCLAIMER:
      # This container declaration format is not a public API and may change without
      # notice. Please use gcloud command-line tool or Google Cloud Console to run
      # Containers on Google Compute Engine.
      spec:
        containers:
        - image: ${var.container_image}
          env:
          - name: "ONE_ENV"
            value: "ONE_VAL"
          name: from-cli-2
          securityContext:
            privileged: false
          stdin: false
          tty: false
          volumeMounts: []
        restartPolicy: Always
        volumes: []
    EOF
    google-logging-enabled    = "true"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    email  = module.application.id
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
  provider = google-beta

  name = module.application.params.md_metadata.name_prefix
  zone = data.google_compute_zones.available.names[0]

  version {
    instance_template = google_compute_instance_template.main.id
    name              = "primary"
  }

  named_port {
    name = "http"
    port = var.port
  }

  target_pools       = [google_compute_target_pool.main.id]
  base_instance_name = "autoscaler-sample"

  # We may be able to remove this
  # We _have_ to add a health check to the backend service, and
  # that will remove unhealthy instances from the managed instance group.
  # If the below check fails, the MIG check will also fail.
  # auto_healing_policies {
  #   health_check      = google_compute_health_check.autohealing.id
  #   initial_delay_sec = 300
  # }
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
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [module.application.params.md_metadata.name_prefix]
}
