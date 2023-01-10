# # It seems like Azure can create a managed cert
# # But it forces you to use key vault to do that
# maybe key vault isn't as bad as we thought?

module "managed_certificate" {
  source              = "../managed-certificate"
  name                = var.name
  resource_group_name = var.resource_group_name
}
