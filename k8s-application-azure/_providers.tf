terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source = "massdriver-cloud/massdriver"
    }
    jq = {
      source = "massdriver-cloud/jq"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = local.kubernetes_cluster_name
  resource_group_name = local.resource_group_name
}

provider "azurerm" {
  features {}

  client_id       = var.azure_authentication.data.client_id
  tenant_id       = var.azure_authentication.data.tenant_id
  client_secret   = var.azure_authentication.data.client_secret
  subscription_id = var.azure_authentication.data.subscription_id
}

provider "azuread" {
  client_id     = var.azure_authentication.data.client_id
  tenant_id     = var.azure_authentication.data.tenant_id
  client_secret = var.azure_authentication.data.client_secret
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}

