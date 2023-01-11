data "http" "token" {
  count  = var.enable_auto_cidr ? 1 : 0
  url    = "https://login.microsoftonline.com/${var.authentication.tenant_id}/oauth2/token"
  method = "POST"

  request_body = "grant_type=Client_Credentials&client_id=${var.authentication.client_id}&client_secret=${var.authentication.client_secret}&resource=https://management.azure.com/"
}

data "http" "vnets" {
  count  = var.enable_auto_cidr ? 1 : 0
  url    = "https://management.azure.com/subscriptions/${var.authentication.subscription_id}/providers/Microsoft.Network/virtualNetworks?api-version=2022-07-01"
  method = "GET"

  request_headers = {
    "Authorization" = "Bearer ${local.token}"
  }
}

data "jq_query" "vnet_cidrs" {
  count = var.enable_auto_cidr ? 1 : 0
  data  = data.http.vnets.0.response_body
  query = "[.value[].properties.addressSpace.addressPrefixes[]]"
}

resource "utility_available_cidr" "cidr" {
  count      = var.enable_auto_cidr ? 1 : 0
  from_cidrs = ["10.0.0.0/8", "172.16.0.0/20", "192.168.0.0/16"]
  used_cidrs = jsondecode(data.jq_query.vnet_cidrs.0.result)
  # why doesn't count handle this?
  mask = var.enable_auto_cidr ? 0 : var.network_mask
}
