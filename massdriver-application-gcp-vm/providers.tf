terraform {
  required_providers {
    jq = {
      source = "massdriver-cloud/jq"
    }

    massdriver = {
      source = "massdriver-cloud/massdriver"
    }

    mdxc = {
      source = "massdriver-cloud/mdxc"
    }

    google = {
      source = "hashicorp/google"
    }

    google-beta = {
      source = "hashicorp/google-beta"
    }

    null = {
      source = "hashicorp/null"
    }
  }
}


