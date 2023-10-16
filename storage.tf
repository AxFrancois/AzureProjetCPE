resource "azurerm_storage_account" "ConfidentielStorageAccount" {
  name                     = "confidentiel"
  resource_group_name      = azurerm_resource_group.RG_CPE.name
  location                 = azurerm_resource_group.RG_CPE.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "CondidentialServices-share-1" {
  name                 = "confidentiel"
  storage_account_name = azurerm_storage_account.ConfidentielStorageAccount.name
  quota                = 250
}