terraform {
  required_version = ">= 1.0"
  required_providers {
        utility = {
      source = "massdriver-cloud/utility"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project     = var.gcp_authentication.data.project_id
  credentials = jsonencode(var.gcp_authentication.data)
  # region      = var.mrc.specs.gcp.region
}
