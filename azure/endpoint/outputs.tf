# https://github.com/hashicorp/terraform-provider-azurerm/issues/16855
# this can be 1-many regional load balancers
output "load_balancer_backend_address_pool_ids" {
  value = azurerm_application_gateway.main.backend_address_pool.*.id
}

output "backend_address_pool" {
  value = azurerm_application_gateway.main.backend_address_pool
}
