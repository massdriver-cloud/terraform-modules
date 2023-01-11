terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    jq = {
      source  = "massdriver-cloud/jq"
      version = "~> 0.0"
    }
    utility = {
      source  = "massdriver-cloud/utility"
      version = "~> 0.0"
    }
  }
}
