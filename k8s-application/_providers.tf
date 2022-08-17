terraform {
  required_version = ">= 1.0"
  required_providers {
    mdxc = {
      source = "massdriver-cloud/mdxc"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}
