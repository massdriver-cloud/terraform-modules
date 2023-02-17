locals {
  zone_name           = var.dns.enable_dns ? regex(".*/dns[z|Z]ones/(.*)$", var.dns.zone_id)[0] : null
  zone_resource_group = var.dns.enable_dns ? regex(".*/resource[g|G]roups/(.*)/providers", var.dns.zone_id)[0] : null
}

data "azurerm_dns_zone" "main" {
  name                = local.zone_name
  resource_group_name = local.zone_resource_group
}

resource "azurerm_dns_txt_record" "main" {
  name                = "asuid.${var.dns.subdomain}"
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  ttl                 = "300"
  tags                = var.tags
  record {
    value = azurerm_container_app.main.custom_domain_verification_id
  }
}

# resource "azurerm_dns_a_record" "main" {
#   name                = var.dns.subdomain
#   zone_name           = data.azurerm_dns_zone.main.name
#   resource_group_name = data.azurerm_dns_zone.main.resource_group_name
#   ttl                 = 300
#   target_resource_id  = azurerm_container_app.main.id
# }

resource "azurerm_dns_cname_record" "main" {
  name                = var.dns.subdomain
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  ttl                 = "300"
  record              = azurerm_container_app.main.ingress.0.fqdn
  tags                = var.tags
}

# data "azurerm_managed_api" "main" {
#   # because of course... https://github.com/hashicorp/terraform-provider-azurerm/issues/1691#issuecomment-409495722
#   # it's not "blob" "blobstorage" or "storageblob" ... it's an entirely new enum
#   name     = "azureblob"
#   location = azurerm_resource_group.main.location
# }

# resource "azurerm_api_connection" "main" {
#   name                = var.name
#   resource_group_name = azurerm_resource_group.main.name
#   managed_api_id      = data.azurerm_managed_api.main.id

#   parameter_values = {
#     # storage_account_name = "localdevsto000"
#     connection_string = "DefaultEndpointsProtocol=https;AccountName=localdevsto000;AccountKey=3df1uB0bdYrB8Afz0Ojw+/2cuNMeLFdOO6jaNSizB/nAn6khrlXg+xvMOpbCpLaqXN9VonuPjuxh+AStXzN5bg==;EndpointSuffix=core.windows.net"
#   }

#   tags = var.tags

#   lifecycle {
#     # NOTE: since the connectionString is a secure value it's not returned from the API
#     ignore_changes = [
#       parameter_values
#     ]
#   }
# }


# https://medium.com/microsoftazure/provisioning-azure-logic-apps-api-connections-with-terraform-980179980b5b
resource "azurerm_resource_group_template_deployment" "connection" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  template_content = data.local_file.api_connection.content

  parameters_content = jsonencode({
    "connectionString" = {
      value = "DefaultEndpointsProtocol=https;AccountName=localdevsto000;AccountKey=3df1uB0bdYrB8Afz0Ojw+/2cuNMeLFdOO6jaNSizB/nAn6khrlXg+xvMOpbCpLaqXN9VonuPjuxh+AStXzN5bg==;EndpointSuffix=core.windows.net"
    },
  })

  deployment_mode = "Incremental"
}

data "local_file" "api_connection" {
  filename = "${path.module}/connection.json"
}
