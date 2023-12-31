resource "azurerm_network_security_group" "JumpStationSecurityGroup" {
  name                = "JumpStationSecurityGroup"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name
}

resource "azurerm_network_security_rule" "JumpStationSecurityRule-1" {
  name                        = "Allow_only_RDP_traffic_from_CPE_network"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "134.214.58.60"
  destination_address_prefix  = azurerm_public_ip.PublicIP-1.ip_address
  resource_group_name         = azurerm_resource_group.RG_CPE.name
  network_security_group_name = azurerm_network_security_group.JumpStationSecurityGroup.name
}

resource "azurerm_network_security_rule" "JumpStationSecurityRule-2" {
  name                        = "Allow_traffic_to_internal_network"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = element(azurerm_virtual_network.System-network-1.address_space, 0)
  destination_address_prefix  = element(azurerm_virtual_network.ConfidentialServices-network-1.address_space, 0)
  resource_group_name         = azurerm_resource_group.RG_CPE.name
  network_security_group_name = azurerm_network_security_group.JumpStationSecurityGroup.name
}