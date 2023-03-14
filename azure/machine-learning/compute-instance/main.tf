resource "azurerm_machine_learning_compute_instance" "main" {
  name                          = var.name
  location                      = var.region
  machine_learning_workspace_id = var.workspace_id
  virtual_machine_size          = var.instance.size
  authorization_type            = "personal"
  tags                          = var.tags
}
