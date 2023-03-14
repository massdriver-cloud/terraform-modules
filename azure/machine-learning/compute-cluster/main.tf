resource "azurerm_machine_learning_compute_cluster" "main" {
  name                          = var.name
  location                      = var.region
  machine_learning_workspace_id = var.workspace_id
  vm_priority                   = "Dedicated"
  vm_size                       = var.cluster.size
  tags                          = var.tags

  scale_settings {
    min_node_count                       = var.cluster.min_nodes
    max_node_count                       = var.cluster.max_nodes
    scale_down_nodes_after_idle_duration = var.cluster.idle_duration
  }
}
