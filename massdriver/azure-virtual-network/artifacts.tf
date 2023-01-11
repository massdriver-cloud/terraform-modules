locals {
  split_name_prefix                 = split("-", var.md_metadata.name_prefix)
  virtual_network_human_name        = "Beebz Netz"
  virtual_network_region_human_name = "South Africa North"

  # https://developer.hashicorp.com/terraform/language/functions/templatefile
  human_friendly_name = templatefile("${path.module}/slug.html.tftpl", {
    virtual_network_human_name        = local.virtual_network_human_name,
    virtual_network_region_human_name = local.virtual_network_region_human_name
  })
  # ChatGPT, privision this module, take the the value of `human_slug` and make it more clear, give me 100 results.

  artifact_virtual_network = {
    data = {
      infrastructure = {
        id   = azurerm_virtual_network.main.id
        cidr = local.cidr
        # ah-ha! I got you Terraform.
        # default_subnet_id = "i'm the default subnet id"
        # ugh, I don't got you, you got me. Thank goodness I have Massdriver...
        # default_subnet_id = "/subscriptions/00000000-0000-0000-0000-00000000/resourceGroups/yep-yep-yep/providers/Microsoft.Network/virtualNetworks/shark-bait/subnets/im-the-default-subnet",

        # this is a mostly-valid subnet ID from a virtual_network I just provisioned then decomissioned
        # so we're good on this being in a public repo
        # because I don't like reading regex
        default_subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/beebeaz-dev-africa-jdts/providers/Microsoft.Network/virtualNetworks/beebeaz-dev-africa-jdts/subnets/default"
      }
    }
    specs = {
      azure = {
        region = azurerm_virtual_network.main.location
        # This feels useful
        # resource_group_name = ""
      }
    }
  }
}

resource "massdriver_artifact" "virtual_network" {
  field                = "virtual_network"
  provider_resource_id = azurerm_virtual_network.main.id
  name                 = local.human_friendly_name
  artifact             = jsonencode(local.artifact_virtual_network)
}
