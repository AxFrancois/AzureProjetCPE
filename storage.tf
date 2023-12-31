resource "azurerm_storage_account" "ConfidentielStorageAccount" {
  name                     = "confidentiel${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.RG_CPE.name
  location                 = azurerm_resource_group.RG_CPE.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # network_rules {
  #   default_action = "Deny"
  #   virtual_network_subnet_ids = [ azurerm_subnet.System-network-1-subnet-1 ]
  # }

  tags = {
    environment = "ConfidentialServices"
  }
}

resource "azurerm_storage_share" "ConfidentialServices-share-1" {
  name                 = "confidentiel"
  storage_account_name = azurerm_storage_account.ConfidentielStorageAccount.name
  quota                = 250
}

resource "azurerm_recovery_services_vault" "ConfidentialRecoveryVault" {
  name                = "ConfidentialRecoveryVault"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
  sku                 = "Standard"
  soft_delete_enabled = false
}

resource "azurerm_backup_policy_vm" "Production-backup-policy" {
  name                = "Production-backup-policy"
  resource_group_name = azurerm_resource_group.RG_CPE.name
  recovery_vault_name = azurerm_recovery_services_vault.ConfidentialRecoveryVault.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 30
  }
}

resource "azurerm_backup_protected_vm" "ProductionVM1-backup" {
  resource_group_name = azurerm_resource_group.RG_CPE.name
  recovery_vault_name = azurerm_recovery_services_vault.ConfidentialRecoveryVault.name
  source_vm_id        = azurerm_virtual_machine.ProductionVM1.id
  backup_policy_id    = azurerm_backup_policy_vm.Production-backup-policy.id
}