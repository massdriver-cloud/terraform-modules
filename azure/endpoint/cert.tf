# # It seems like Azure can create a managed cert
# # But it forces you to use key vault to do that
# maybe key vault isn't as bad as we thought?

module "managed_certificate" {
  source                              = "../managed-certificate"
  name                                = var.name
  resource_group_name                 = data.azurerm_resource_group.main.name
  user_assigned_identity_principal_id = var.user_assigned_identity_principal_id
  full_domain                         = "${var.subdomain}.${var.domain}"
  # gateway_service_id = azurerm_application_gateway.main.id
}
