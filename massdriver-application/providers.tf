terraform {
  required_providers {
    jq = {
      source = "massdriver-cloud/jq"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    mdxc = {
      source  = "massdriver-cloud/mdxc"
      version = ">= 0.10.3"
    }
  }
}
