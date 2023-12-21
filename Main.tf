resource "azurerm_resource_group" "Abhi_RG" {
  name     = "Abhi_RG"
  location = "West Europe"
}

resource "azurerm_virtual_network" "Abhi_RG" {
  name                = "Abhi-VN-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Abhi_RG.location
  resource_group_name = azurerm_resource_group.Abhi_RG.name
}

resource "azurerm_subnet" "Abhi_RG" {
  name                 = "Abhi_Subnet"
  resource_group_name  = azurerm_resource_group.Abhi_RG.name
  virtual_network_name = azurerm_virtual_network.Abhi_RG.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "Abhi_RG" {
  name                = "Abhi-nic"
  location            = azurerm_resource_group.Abhi_RG.location
  resource_group_name = azurerm_resource_group.Abhi_RG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Abhi_RG.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "Abhi_RG" {
  name                = "Abhi-VM"
  resource_group_name = azurerm_resource_group.Abhi_RG.name
  location            = azurerm_resource_group.Abhi_RG.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.Abhi_RG.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_public_ip" "Abhi_RG" {
  name                = "Abhi_Public_IP"
  resource_group_name = azurerm_resource_group.Abhi_RG.name
  location            = azurerm_resource_group.Abhi_RG.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
}