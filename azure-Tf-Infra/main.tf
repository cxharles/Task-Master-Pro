resource "azurerm_resource_group" "az-test" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_container_group" "az-test-container" {
  name                = var.container_name
  location            = azurerm_resource_group.az-test.location
  resource_group_name = azurerm_resource_group.az-test.name

  ip_address_type = "Public"
  dns_name_label  = "charlesjatto-label"
  os_type         = "Linux"

  container {
    name   = "task-master-pro"
    image  = "charlesjatto/taskmaster"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}