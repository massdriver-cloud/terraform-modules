terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    utility = {
      source = "massdriver-cloud/utility"
    }
  }
}
