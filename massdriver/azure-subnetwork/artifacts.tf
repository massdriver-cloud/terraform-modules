locals {
  # I always get the order of split wrong. What's it in Javascript, Ruby, etc...
  split_name_prefix = split("-", var.md_metadata.name_prefix)
  # funny thing is, I think this is shorter than what some of these are today
  human_slug = "Azure Subnetwork connected to `Beebe's` Azure Virtual Network located in the `South Africa North` region."
  # TODO: ChatGPT, say ^ better.

  artifact_subnetwork = {
    # TODO: think about how to take the ability away from users to make our UI and thier platform gross-looking
    human_friendly_name = local.human_slug
    data = {
      infrastructure = {
        id                = azurerm_subnet.main.id
        cidr              = var.network_mask
        default_subnet_id = azurerm_subnet.main.id
      }
    }
    specs = {
      azure = {
        region = var.region
      }
    }
  }
}

resource "massdriver_artifact" "subnetwork" {
  field                = "subnetwork"
  provider_resource_id = azurerm_subnet.main.id
  # TODO: go through these on all clouds.
  name     = local.artifact_subnetwork.human_friendly_name
  artifact = jsonencode(local.artifact_subnetwork)
}
