locals {
  split_vnet_id        = split("/", var.virtual_network_id)
  vnet_name            = element(local.split_vnet_id, length(local.split_vnet_id) - 1)
  vnet_resource_group  = element(local.split_vnet_id, index(local.split_vnet_id, "resourceGroups") + 1)
  max_length           = 24
  storage_account_name = substr(replace(var.name, "/[^a-z0-9]/", ""), 0, local.max_length)
}

module "application" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=b4401ac"
  name                = var.name
  service             = "vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                            = var.name
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  disable_password_authentication = false
  admin_username                  = "placeholder"
  admin_password                  = random_password.main.result
  # instances                       = var.auto_scaling.enabled ? var.scaleset.instances : 1
  # TODO: better var
  instances = 1
  # TODO: configurable
  sku         = "Standard_F2"
  custom_data = base64encode(local.cloud_init_rendered)
  # health_probe_id              = var.dns.enable_dns ? module.public_endpoint[0].azurerm_lb_probe : null
  extension_operations_enabled = false
  tags                         = var.tags

  network_interface {
    name    = var.name
    primary = true
    # network_security_group_id = var.dns.enable_dns ? module.public_endpoint[0].azurerm_network_security_group_id : null

    dynamic "ip_configuration" {
      for_each = var.dns.enable_dns ? [] : [1]
      content {
        name      = var.name
        subnet_id = data.azurerm_subnet.default.id
        primary   = true
      }
    }

    dynamic "ip_configuration" {
      for_each = var.dns.enable_dns ? [1] : []
      content {
        name      = var.name
        subnet_id = data.azurerm_subnet.default.id
        # load_balancer_backend_address_pool_ids = module.public_endpoint.0.load_balancer_backend_address_pool_ids
        # load_balancer_inbound_nat_rules_ids    = module.public_endpoint.0.load_balancer_inbound_nat_rules_ids
        application_gateway_backend_address_pool_ids = module.public_endpoint.0.load_balancer_backend_address_pool_ids
        primary                                      = true
        # public_ip_address {
        #   name = "public"
        # }
      }
    }
  }

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set#storage_account_uri
  # Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics.
  # might be able to drop the storage account for this
  boot_diagnostics {
    storage_account_uri = null
    # storage_account_uri = azurerm_storage_account.main.primary_blob_endpoint
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [module.application.identity.azure_application_identity.resource_id]
  }

  provision_vm_agent = true

  # az vm image list-offers --publisher Canonical --location westeurope -o table | grep server
  # az vm image list-skus --publisher Canonical --offer 0001-com-ubuntu-server-jammy --location westeurope -o table
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  scale_in {
    rule = "OldestVM"
  }

  # upgrade_mode = "Automatic"

  # rolling_upgrade_policy {
  #   max_batch_instance_percent              = 30
  #   max_unhealthy_instance_percent          = 60
  #   max_unhealthy_upgraded_instance_percent = 60
  #   pause_time_between_batches              = "PT5M"
  # }

  #   automatic_os_upgrade_policy {
  #     enable_automatic_os_upgrade = true
  #     disable_automatic_rollback  = false
  #   }

  # https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-health-extension#when-to-use-the-application-health-extension
    #  extension {
    #   name                       = "HealthExtension"
    #   publisher                  = "Microsoft.ManagedServices"
    #   type                       = "ApplicationHealthLinux"
    #   type_handler_version       = "1.0"
    #   auto_upgrade_minor_version = false

    #   settings = jsonencode({
    #     protocol    = "http"
    #     port        = var.health_check.port
    #     requestPath = var.health_check.path
    #   })
    # }


  # To enable the automatic instance repair, this Virtual Machine Scale Set must have a valid health_probe_id o
  # dynamic "automatic_instance_repair" {
  #   for_each = var.dns.enable_dns ? [1] : []
  #   content {
  #     enabled      = true
  #     grace_period = "PT30M"
  #   }
  # }

  lifecycle {
    ignore_changes = [
      # this is like an "initial instance count" and should be ignored on subsequent runs
      instances
    ]
  }

  depends_on = [
    module.public_endpoint
  ]
}

resource "random_password" "main" {
  length      = 16
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}
