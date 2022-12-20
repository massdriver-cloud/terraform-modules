data "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  resource_group_name = local.vnet_resource_group
}

data "azurerm_subnet" "default" {
  name                 = "default"
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_virtual_network.main.resource_group_name
}

resource "azurerm_public_ip" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  domain_name_label   = var.name
  tags                = var.tags
}

resource "azurerm_lb" "main" {
  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  sku_tier            = "Regional"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
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
  port            = 80
  request_path    = "/health"
}

resource "azurerm_lb_rule" "main" {
  name                           = "Rule1"
  loadbalancer_id                = azurerm_lb.main.id
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
  probe_id                       = azurerm_lb_probe.main.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
}

resource "azurerm_lb_nat_rule" "main" {
  name                           = "NatRule1"
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.main.id
  frontend_ip_configuration_name = azurerm_lb.main.frontend_ip_configuration.0.name
  protocol                       = "Tcp"
  backend_port                   = 80
}

resource "azurerm_lb_outbound_rule" "main" {
  name            = "OutboundRule1"
  loadbalancer_id = azurerm_lb.main.id
  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
  protocol                = "Tcp"
}
