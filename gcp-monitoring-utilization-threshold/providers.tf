terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
  }
}
