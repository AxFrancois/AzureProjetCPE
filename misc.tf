resource "random_string" "resource_code" {
  length  = 8
  special = false
  upper   = false
}

output "ConfidentielStorageAccountName" {
  value = azurerm_storage_account.ConfidentielStorageAccount.name
}

output "KeyVaultName" {
  value = azurerm_key_vault.KeyVault1.name
}