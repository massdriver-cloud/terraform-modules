terraform {
  required_providers {
    utility = {
      source = "massdriver-cloud/utility"
    }

    google = {
      source = "hashicorp/google"
    }

    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}
