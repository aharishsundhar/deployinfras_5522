provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource
  location = var.location
}
resource "azurerm_virtual_network" "example" {
  name                = var.vnet
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/23"]
}
resource "azurerm_subnet" "example_2" {
  name                 = "${var.subnet}-1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_log_analytics_workspace" "example" {
  name                = var.log
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "example" {
  name                       = var.env
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
  infrastructure_subnet_id   = azurerm_subnet.example.id
}
resource "azurerm_container_app" "example" {
  name                         = var.containerapp
  container_app_environment_id = azurerm_container_app_environment.example.id
  resource_group_name          = azurerm_resource_group.example.name
  revision_mode                = "Single"
  registry {
    server               = var.registry
    username             = var.registry_username
    password_secret_name = "mypassword"
  }
  secret {
    name  = "mypassword"
    value = var.registry_password
  }

  template {

    container {
      name   = "examplecontainerapp"
      image  = "ghost:latest"
      cpu    = 0.25
      memory = "0.5Gi"
      env {
        name  = "NODE_ENV"
        value = "development"
      }
    }
    revision_suffix = "v1"

  }

  ingress {
    external_enabled = true
    transport        = "http"
    target_port      = 2368
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

}