# Might be the only way to get SSL termination
# The load balancer resource in Azure in L4
# Pushing users to use this.
#

locals {
  gateway_ip_configuration_name    = "gateway_ip_name"
  frontend_port_name_http          = "frontend_port_http"
  frontend_port_name_https         = "frontend_port_https"
  frontend_ip_configuration_name   = "frontend_ip"
  listener_name_http               = "listener_name_http"
  listener_name_https              = "listener_name_https"
  backend_http_settings_name_http  = "http_setting_http"
  backend_http_settings_name_https = "http_setting_https"
  backend_http_settings_name       = "backend_http"
  request_routing_rule_name_http   = "rrr_http"
  request_routing_rule_name_https  = "rrr_https"
  redirect_configuration_name      = "rcffg"
  backend_url_path_map_name        = "pathh"
  backend_address_pool_name        = "backend_pool"
  frontend_port_name               = "port_n"
  backend_probe                    = "probe"
}

resource "azurerm_application_gateway" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  # v1
  # ssl_certificate {
  #   name = module.managed_certificate.ssl_certificate_name
  #   data = module.managed_certificate.ssl_certificate_data
  # }
  # v2
  ssl_certificate {
    name                = module.managed_certificate.ssl_certificate_name
    key_vault_secret_id = module.managed_certificate.ssl_certificate_secret_id
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = local.frontend_port_name_http
    port = 80
  }

  frontend_port {
    name = local.frontend_port_name_https
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.main.id
  }

  # HTTP Listener
  http_listener {
    name                           = local.listener_name_http
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name_http
    protocol                       = "Http"
    host_name                      = local.full_domain
  }

  # HTTPS Listener
  http_listener {
    name                           = local.listener_name_https
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name_https
    protocol                       = "Https"
    ssl_certificate_name           = module.managed_certificate.ssl_certificate_name
  }

  probe {
    name                = local.backend_probe
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 30
    protocol            = "Http"
    path                = var.health_check.path
    port                = 80
    # host = local.full_domain
    pick_host_name_from_backend_http_settings = true
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                                = local.backend_http_settings_name
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    probe_name                          = local.backend_probe
    pick_host_name_from_backend_address = true
  }

  redirect_configuration {
    name                 = local.redirect_configuration_name
    redirect_type        = "Permanent"
    target_listener_name = local.listener_name_https
    include_path         = true
    include_query_string = true
  }

  # Routing rule for http requests
  request_routing_rule {
    name                        = local.request_routing_rule_name_http
    rule_type                   = "Basic"
    http_listener_name          = local.listener_name_http
    redirect_configuration_name = local.redirect_configuration_name
    priority                    = 1
  }

  # Routing rule for https requests
  request_routing_rule {
    name                       = local.request_routing_rule_name_https
    rule_type                  = "PathBasedRouting"
    http_listener_name         = local.listener_name_https
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.backend_http_settings_name
    priority                   = 2
    url_path_map_name          = local.backend_url_path_map_name
  }

  url_path_map {
    name                               = local.backend_url_path_map_name
    default_backend_address_pool_name  = local.backend_address_pool_name
    default_backend_http_settings_name = local.backend_http_settings_name

    # Supposedly, you do not need to add a custom /* path rule to handle default cases.
    # This is automatically handled by the default backend pool.
    # but a path_rule is required... soo...
    path_rule {
      name                       = "path_rulez"
      paths                      = ["/*"]
      backend_address_pool_name  = local.backend_address_pool_name
      backend_http_settings_name = local.backend_http_settings_name
    }
  }

  # So the gateway can access vault to get the cert!
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }

  depends_on = [
    module.managed_certificate
  ]
}
