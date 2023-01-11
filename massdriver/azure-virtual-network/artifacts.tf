locals {
  artifact_virtual_network = {
    data = {
      infrastructure = {
        id   = azurerm_virtual_network.main.id
        cidr = local.cidr
      }
    }
    specs = {
      azure = {
        region = azurerm_virtual_network.main.location
      }
    }
  }
}

resource "massdriver_artifact" "virtual_network" {
  field                = "virtual_network"
  provider_resource_id = azurerm_virtual_network.main.id
  # We need to inspect these evvvverryyyywhere. I mean everywheree. All of GCP, I don't know about AWS, all of Azure
  # We don't have consistency and in some places it's v gross in the UI
  name     = "Virtual Network ${var.md_metadata.name_prefix}"
  artifact = jsonencode(local.artifact_virtual_network)
}
