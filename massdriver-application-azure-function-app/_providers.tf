terraform {
  required_providers {
    jq = {
      source = "massdriver-cloud/jq"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    utility = {
      source = "massdriver-cloud/utility"
    }

    mdxc = {
      source  = "massdriver-cloud/mdxc"
      version = ">= 0.10.3"
    }
  }
}
