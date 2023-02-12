terraform {
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    mdxc = {
      source  = "massdriver-cloud/mdxc"
      version = ">= 0.10.3"
    }

    jq = {
      source = "massdriver-cloud/jq"
    }

    utility = {
      source = "massdriver-cloud/utility"
    }

    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
