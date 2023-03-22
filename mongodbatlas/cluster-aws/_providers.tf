terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    random = {
      source = "hashicorp/random"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}
