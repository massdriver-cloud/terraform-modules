# this can be 1-many regional load balancers
output "load_balancer_backend_address_pool_ids" {
  value = [azurerm_lb_backend_address_pool.main.id]
  # value = null
}

output "azurerm_lb_probe" {
  value = azurerm_lb_probe.main.id
}

output "load_balancer_inbound_nat_rules_ids" {
  value = [azurerm_lb_nat_pool.main.id]
}

output "azurerm_network_security_group_id" {
  value = azurerm_network_security_group.main.id
}
