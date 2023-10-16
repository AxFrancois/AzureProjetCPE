resource "azurerm_network_interface" "JumpStationVM1-NIC" {
  name                = "JumpStationVM1-NIC"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name

  ip_configuration {
    name                          = "PrimaryIP"
    subnet_id                     = azurerm_subnet.System-network-1-subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.PublicIP-1.id
  }
}

resource "azurerm_virtual_machine" "JumpStationVM1" {
  name                  = "JumpStationVM1"
  location              = azurerm_resource_group.RG_CPE.location
  resource_group_name   = azurerm_resource_group.RG_CPE.name
  network_interface_ids = [azurerm_network_interface.JumpStationVM1-NIC.id]
  vm_size               = "Standard_B2s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myvm1"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  tags = {
    environment = "System"
  }
}

resource "azurerm_network_interface" "ProductionVM1-NIC" {
  name                = "ProductionVM1-NIC"
  location            = azurerm_resource_group.RG_CPE.location
  resource_group_name = azurerm_resource_group.RG_CPE.name

  ip_configuration {
    name                          = "PrimaryIP"
    subnet_id                     = azurerm_subnet.CondidentialServices-network-1-subnet-1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "ProductionVM1" {
  name                  = "ProductionVM1"
  location              = azurerm_resource_group.RG_CPE.location
  resource_group_name   = azurerm_resource_group.RG_CPE.name
  network_interface_ids = [azurerm_network_interface.ProductionVM1-NIC.id]
  vm_size               = "Standard_B2s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Windows"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "myvm1"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  tags = {
    environment = "System"
  }
}