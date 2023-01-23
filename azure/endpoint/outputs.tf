# data "azurerm_lb_backend_address_pool" "main" {
#   name            = var.name
#   loadbalancer_id = azurerm_application_gateway.main.backend_address_pool
# }

# backend_address_pool
# https://github.com/hashicorp/terraform-provider-azurerm/issues/16855
# this can be 1-many regional load balancers
output "load_balancer_backend_address_pool_ids" {
  value = azurerm_application_gateway.main.backend_address_pool.*.id
  # value = []
  # value = null
}

# output "azurerm_lb_probe" {
#   value = azurerm_lb_probe.main.id
# }

output "load_balancer_inbound_nat_rules_ids" {
  # value = [azurerm_lb_nat_pool.main.id]
  value = []
}

output "backend_address_pool" {
  value = azurerm_application_gateway.main.backend_address_pool
}

output "azurerm_network_security_group_id" {
  value = azurerm_network_security_group.main.id
}
