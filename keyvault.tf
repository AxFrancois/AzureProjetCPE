resource "azurerm_key_vault" "KeyVault1" {
  name                        = "KeyVault${random_string.resource_code.result}"
  location                    = azurerm_resource_group.RG_CPE.location
  resource_group_name         = azurerm_resource_group.RG_CPE.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "KeyVaultAccessPolicy1" {
  key_vault_id = azurerm_key_vault.KeyVault1.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azuread_group.IT.id

  certificate_permissions = [
    "Get", "List", "Delete", "Create", "Import", "Update", "ManageContacts", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "ManageIssuers", "Recover", "Purge"
  ]

  key_permissions = [
    "Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "UnwrapKey", "WrapKey", "Encrypt", "Decrypt", "Import", "Update"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
  ]

  storage_permissions = [
    "Get", "List", "Delete", "Recover", "Backup", "Restore", "RegenerateKey", "Set", "Update"
  ]
}

resource "azurerm_key_vault_access_policy" "KeyVaultAccessPolicy2" {
  key_vault_id = azurerm_key_vault.KeyVault1.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azuread_group.AF.id

  key_permissions = [
    "Get", "List", "Create"
  ]

  secret_permissions = [
    "Get", "List", "Set"
  ]

  storage_permissions = [
    "Get", "List", "Set"
  ]
}