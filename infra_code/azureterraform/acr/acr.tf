provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource
  location = var.location
}
resource "azurerm_container_registry" "acr" {
  name                = var.cr
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
  admin_enabled       = true
  provisioner "local-exec" {
    command = "az acr build --registry $REGISTRY_NAME --image $IMAGE_NAME ../tweet-sample/tweet-app/. "
    environment = {
      REGISTRY_NAME = var.cr
      IMAGE_NAME    = "demoapp"
    }
  }
}
