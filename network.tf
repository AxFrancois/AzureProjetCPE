resource "azurerm_virtual_network" "System-network-1" {
  name                = "System-network-1"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
  address_space       = ["192.168.0.0/24"]

  tags = {
    environment = "System"
  }
}

resource "azurerm_subnet" "System-network-1-subnet-1" {
  name                 = "System-network-1-subnet-1"
  resource_group_name  = azurerm_resource_group.RG_CPE.name
  virtual_network_name = azurerm_virtual_network.System-network-1.name
  address_prefixes     = ["192.168.0.0/25"]
}

resource "azurerm_subnet" "System-network-1-subnet-2" {
  name                 = "System-network-1-subnet-2"
  resource_group_name  = azurerm_resource_group.RG_CPE.name
  virtual_network_name = azurerm_virtual_network.System-network-1.name
  address_prefixes     = ["192.168.0.128/25"]
}

resource "azurerm_virtual_network" "CondidentialServices-network-1" {
  name                = "CondidentialServices-network-1"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
  address_space       = ["172.16.0.0/16"]

  tags = {
    environment = "CondidentialServices"
  }
}

resource "azurerm_subnet" "CondidentialServices-network-1-subnet-1" {
  name                 = "CondidentialServices-network-1-subnet-1"
  resource_group_name  = azurerm_resource_group.RG_CPE.name
  virtual_network_name = azurerm_virtual_network.CondidentialServices-network-1.name
  address_prefixes     = ["172.16.0.0/16"]
}

resource "azurerm_virtual_network_peering" "SystemToConfidentialServices" {
  name                      = "SystemToConfidentialServices"
  resource_group_name       = azurerm_resource_group.RG_CPE.name
  virtual_network_name      = azurerm_virtual_network.System-network-1.name
  remote_virtual_network_id = azurerm_virtual_network.CondidentialServices-network-1.id
}

resource "azurerm_virtual_network_peering" "ConfidentialServicesToSystem" {
  name                      = "ConfidentialServicesToSystem"
  resource_group_name       = azurerm_resource_group.RG_CPE.name
  virtual_network_name      = azurerm_virtual_network.CondidentialServices-network-1.name
  remote_virtual_network_id = azurerm_virtual_network.System-network-1.id
}

resource "azurerm_public_ip" "PublicIP-1" {
  name                = "PublicIP-1"
  resource_group_name = azurerm_resource_group.RG_CPE.name
  location            = azurerm_resource_group.RG_CPE.location
  allocation_method   = "Static"

  tags = {
    environment = "System"
  }
}