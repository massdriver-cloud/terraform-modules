terraform {
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    utility = {
      source = "massdriver-cloud/utility"
    }

    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
