resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
}