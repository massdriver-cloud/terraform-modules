# Might be the only way to get SSL termination
# The load balancer resource in Azure in L4
# Pushing users to use this.
#

locals {
  frontend_port_name             = "frontend_port"
  frontend_ip_configuration_name = "frontend_ip"
  listener_name                  = "listener_name"
  http_setting_name              = "http_setting"
  request_routing_rule_name      = "rrr_name"
}

resource "azurerm_user_assigned_identity" "main" {
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  name                = "${var.name}-cert"
}

resource "azurerm_application_gateway" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.main.id
  }

  backend_address_pool {
    name = azurerm_lb_backend_address_pool.main.name
  }

  backend_http_settings {
    name                  = "default"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = var.port
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = module.managed_certificate.ssl_certificate_name
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = azurerm_lb_backend_address_pool.main.name
    backend_http_settings_name = local.http_setting_name
  }

  # So the gateway can access vault to create and store / rotate the cert!
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }
}
