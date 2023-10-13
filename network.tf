resource "azurerm_virtual_network" "System-network-1" {
  name                = "System-network-1"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
  address_space       = ["192.168.0.0/24"]

  subnet {
    name           = "subnet1"
    address_prefix = "192.168.0.0/25"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "192.168.0.128/25"
    #security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "System"
  }
}