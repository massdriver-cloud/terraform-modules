terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    aws = {
      source = "hashicorp/aws"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = local.k8s_cluster_name
}

data "aws_eks_cluster_auth" "auth" {
  name = local.k8s_cluster_name
}

provider "aws" {
  region = local.region_hack
  assume_role {
    role_arn    = var.aws_authentication.data.arn
    external_id = var.aws_authentication.data.external_id
  }
  default_tags {
    tags = var.md_metadata.default_tags
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.auth.token
  }
}