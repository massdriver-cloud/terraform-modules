locals {
  split_vnet_id        = split("/", var.virtual_network_id)
  vnet_name            = element(local.split_vnet_id, length(local.split_vnet_id) - 1)
  vnet_resource_group  = element(local.split_vnet_id, index(local.split_vnet_id, "resourceGroups") + 1)
  max_length           = 24
  storage_account_name = substr(replace(var.name, "/[^a-z0-9]/", ""), 0, local.max_length)
}

module "application" {
  source                  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=22d422e"
  name                    = var.name
  service                 = "function"
  application_identity_id = azurerm_linux_virtual_machine_scale_set.main.identity[0].principal_id
  # We aren't creating an application identity for this module because we are assigning permissions directly to the system-assigned managed identity of the function app.
  create_application_identity = false
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

resource "random_password" "master_password" {
  length      = 16
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                            = var.name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  admin_username                  = var.vm.admin_username
  admin_password                  = random_password.master_password.result
  instances                       = var.scaleset.enable_scaleset ? var.scaleset.instances : 1
  sku                             = var.vm.vm_size
  custom_data                     = data.template_cloudinit_config.config.rendered
  health_probe_id                 = azurerm_lb_probe.main.id
  disable_password_authentication = false
  extension_operations_enabled    = false
  tags                            = var.tags

  network_interface {
    name    = var.name
    primary = true

    # This will create a /24 subnet for the VMSS if they want autoscaling, otherwise it'll just add the VMSS to the default subnet.
    ip_configuration {
      name                                   = var.name
      subnet_id                              = data.azurerm_subnet.default.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.main.id]
      primary                                = true
    }
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.main.primary_blob_endpoint
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm.disk_type
  }

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # Seems like this is a requirement for autoscaling so that the instance number does not get reset if other changes are made for VMSS while it's scaling due to metrics.
  lifecycle {
    ignore_changes = [instances]
  }
}
