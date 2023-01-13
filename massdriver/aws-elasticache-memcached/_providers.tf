terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      version = "~> 1.0"
      source  = "massdriver-cloud/massdriver"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

