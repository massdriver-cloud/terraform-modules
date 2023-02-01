# This is an identity for the Application Gateway.
# The principal_id is passed to the managed-certificate module
# and that module sets access rules to the key vault.
# This enables the Gateway to retrieve the SSL certificate.
resource "azurerm_user_assigned_identity" "main" {
  name                = "${var.name}-gateway"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
}
# no role assignments are expected here!
