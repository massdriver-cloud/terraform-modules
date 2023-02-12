module "application" {
  source              = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=fc5f7b1"
  name                = var.name
  service             = "function"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_container_app_environment" "main" {
  name                       = var.name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  tags                       = var.tags
  infrastructure_subnet_id   = azurerm_subnet.main.id
}

resource "azurerm_container_app" "main" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Multiple"

  template {
    min_replicas = 1
    max_replicas = 5 # var.max_replicas
    container {
      name   = var.name
      image  = "${var.container.repository}:${var.container.tag}"
      cpu    = var.resource_requests.cpu
      memory = var.resource_requests.memory
      # can't do dynamic envs with sensitive values
      env {
        name  = "AZURE_STORAGE_ACCOUNT_NAME"
        value = "azurebeebeprodewcnw"
      }
      env {
        name  = "AZURE_CLIENT_ID"
        value = module.application.identity.azure_application_identity.client_id
      }
      env {
        name  = "AZURE_TENANT_ID"
        value = module.application.identity.azure_application_identity.tenant_id
      }

      liveness_probe {
        port      = 80
        path      = "/health"
        transport = "HTTP"
      }

      readiness_probe {
        port      = 80
        path      = "/health"
        transport = "HTTP"
      }

      startup_probe {
        port      = 80
        path      = "/health"
        transport = "HTTP"
      }
    }
  }

  ingress {
    transport                  = "http"
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      module.application.identity.azure_application_identity.resource_id,
      # azurerm_user_assigned_identity.container.id
    ]
  }

  tags = var.tags
  depends_on = [
    azurerm_role_assignment.acr
  ]
}
