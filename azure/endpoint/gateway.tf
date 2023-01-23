# Might be the only way to get SSL termination
# The load balancer resource in Azure in L4
# Pushing users to use this.
#

locals {
  gateway_ip_configuration_name   = "gateway_ip_name"
  frontend_port_name_http         = "frontend_port_http"
  frontend_port_name_https        = "frontend_port_https"
  frontend_ip_configuration_name  = "frontend_ip"
  listener_name_http              = "listener_name_http"
  listener_name_https             = "listener_name_https"
  http_setting_name               = "http_setting"
  request_routing_rule_name_http  = "rrr_http"
  request_routing_rule_name_https = "rrr_https"
  redirect_configuration_name     = "rcffg"
  backend_url_path_map_name       = "pathh"
  backend_address_pool_name       = "backend_pool"
  #  azurerm_lb_backend_address_pool.main.name
  frontend_port_name = "port_n"
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

  ssl_certificate {
    name = module.managed_certificate.ssl_certificate_name
    data = module.managed_certificate.ssl_certificate_data
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

  # HTTPS Listener
  http_listener {
    name                           = local.listener_name_https
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name_https
    protocol                       = "Https"
    ssl_certificate_name           = module.managed_certificate.ssl_certificate_name
  }

  # HTTP Listener
  http_listener {
    name                           = local.listener_name_http
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name_http
    protocol                       = "Http"
    host_name                      = "${var.subdomain}.${var.domain}"
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }
  # # Backend pool for the Client
  # backend_address_pool {
  #   name  = local.backend_address_pool_name
  #   fqdns = [regex("https://(.*)/", var.storage_domain_name)[0]]
  # }

  # # Backend pool for the Server
  # backend_address_pool {
  #   name  = "${local.backend_address_pool_name}-api"
  #   fqdns = [var.server_domain_name]
  # }

  backend_http_settings {
    name                  = "default"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = var.port
    protocol              = "Http"
    request_timeout       = 60
  }

  # probe {
  #   name                = local.backend_probe
  #   protocol            = "Https"
  #   path                = "/"
  #   host                = var.server_domain_name
  #   interval            = 10
  #   timeout             = 30
  #   unhealthy_threshold = 3
  #   match {
  #     status_code = ["401"]
  #   }
  # }

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
  }

  # Routing rule for https requests
  request_routing_rule {
    name                       = local.request_routing_rule_name_https
    rule_type                  = "PathBasedRouting"
    http_listener_name         = local.listener_name_https
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    url_path_map_name          = local.backend_url_path_map_name
  }

  # So the gateway can access vault to create and store / rotate the cert!
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }
}
