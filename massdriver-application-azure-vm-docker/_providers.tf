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

    acme = {
      source = "vancluever/acme"
    }
  }
}


# provider "azurerm" {
#   features {}

#   client_id       = var.azure_service_principal.data.client_id
#   tenant_id       = var.azure_service_principal.data.tenant_id
#   client_secret   = var.azure_service_principal.data.client_secret
#   subscription_id = var.azure_service_principal.data.subscription_id
# }

# provider "mdxc" {
#   azure = {
#     client_id       = var.azure_service_principal.data.client_id
#     tenant_id       = var.azure_service_principal.data.tenant_id
#     client_secret   = var.azure_service_principal.data.client_secret
#     subscription_id = var.azure_service_principal.data.subscription_id
#   }
# }

# provider "acme" {
#   server_url = "https://acme-v02.api.letsencrypt.org/directory"
# }
