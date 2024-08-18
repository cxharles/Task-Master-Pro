# Azure storage account
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.az-test.name
  location                 = azurerm_resource_group.az-test.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type


}

# Azure container storage
resource "azurerm_storage_container" "storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type # for access to internet change to "blob"

}