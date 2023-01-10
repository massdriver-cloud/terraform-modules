# Might be the only way to get SSL termination
# The load balancer resource in Azure in L4
# Pushing users to use this.
#

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
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
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
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "frontend-port"
    protocol                       = "Https"
    ssl_certificate_name           = module.managed_certificate.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = azurerm_lb_backend_address_pool.main.name
    backend_http_settings_name = "backend-settings"
  }
}
