provider "azurerm" {
  features {}
  skip_provider_registration = true
  client_id                  = "1e4976f3-a80b-4059-b7ba-0da7f7360336"
  client_secret              = "Gwg8Q~gLkM02zRK_wTKue3rMGEISOwywparO6ajN"
  tenant_id                  = "ad8176b1-27ae-4f83-a5b4-f8f9e0943c43"
  subscription_id            = "1a3b0acb-91f2-42fe-8641-72fc6021071b"
}

terraform {
    backend "azurerm" {
        resource_group_name  = "az-dev-project"
        storage_account_name = "charlesbackendstorage"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "az-dev-env" {
  name     = "az-dev-project"
  location = "canadacentral"
}

resource "azurerm_container_group" "az-cg-dev-env" {
  name                = "az-cg-dev-project"
  location            = azurerm_container_group.az-cg-dev-env.location
  resource_group_name = azurerm_resource_group.az-dev-env.name

  ip_address_type = "public"
  dns_name_label  = "azproject"
  os_type         = "Linux"

  container {
    name   = "todo-app"
    image  = "charlesjatto/todo-app:{}"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}