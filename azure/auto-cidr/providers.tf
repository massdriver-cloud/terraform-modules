terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    utility = {
      source = "massdriver-cloud/utility"
    }
  }
}
