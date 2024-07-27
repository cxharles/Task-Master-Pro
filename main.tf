provider "azurerm" {
  features {}
  skip_provider_registration = true
  client_id                  = ""
  client_secret              = ""
  tenant_id                  = ""
  subscription_id            = ""
}

terraform {
    backend "azurerm" {
        resource_group_name  = "az-dev-project"
        storage_account_name = "charlesbackendstorage"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "az-dev-env" {
  name     = "az-dev-project"
  location = "canadacentral"
}

resource "azurerm_container_group" "az-cg-dev-env" {
  name                = "az-cg-dev-project"
  location            = azurerm_container_group.az-cg-dev-env.location
  resource_group_name = azurerm_resource_group.az-dev-env.name

  ip_address_type = "Public"
  dns_name_label  = "azproject"
  os_type         = "Linux"

  container {
    name   = "todo-app"
    image  = "charlesjatto/todo-app"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}