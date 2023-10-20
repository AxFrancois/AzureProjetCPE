resource "azurerm_storage_account" "ConfidentielStorageAccount" {
  name                     = "confidentiel${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.RG_CPE.name
  location                 = azurerm_resource_group.RG_CPE.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = false
}

resource "azurerm_storage_share" "CondidentialServices-share-1" {
  name                 = "confidentiel"
  storage_account_name = azurerm_storage_account.ConfidentielStorageAccount.name
  quota                = 250
}

resource "azurerm_recovery_services_vault" "ConfidentialRecoveryVault" {
  name                = "ConfidentialRecoveryVault"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
  sku                 = "Standard"
}

resource "azurerm_backup_policy_vm" "ProductionVM1-backup-policy" {
  name                = "ProductionVM1-backup-policy"
  resource_group_name = azurerm_resource_group.RG_CPE.name
  recovery_vault_name = azurerm_recovery_services_vault.ConfidentialRecoveryVault.name

  timezone = "UTC+2"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 30
  }
}