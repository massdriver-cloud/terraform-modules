data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_public_ip" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  domain_name_label   = var.subdomain
  tags                = var.tags
}

resource "azurerm_lb" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = var.name
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name            = var.name
  loadbalancer_id = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
  name            = var.name
  loadbalancer_id = azurerm_lb.main.id
  protocol        = "Http"
  port            = var.health_check.port
  request_path    = var.health_check.path
}

# resource "azurerm_lb_rule" "main" {
#   name                           = var.name
#   loadbalancer_id                = azurerm_lb.main.id
#   frontend_ip_configuration_name = azurerm_lb.main.frontend_ip_configuration.0.name
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
#   probe_id                       = azurerm_lb_probe.main.id
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   disable_outbound_snat          = true
#   enable_floating_ip             = true
# }

resource "azurerm_lb_nat_pool" "main" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.main.id
  name                           = var.name
  protocol                       = "Tcp"
  frontend_port_start            = 5000
  frontend_port_end              = 6000
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.main.frontend_ip_configuration.0.name
}

resource "azurerm_lb_outbound_rule" "main" {
  name            = var.name
  loadbalancer_id = azurerm_lb.main.id
  frontend_ip_configuration {
    name = azurerm_lb.main.frontend_ip_configuration.0.name
  }
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
  protocol                = "Tcp"
}
