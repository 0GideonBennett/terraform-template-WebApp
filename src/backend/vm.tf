#Resource Group + VNet + Subnet + NSG + NIC + Linux VM


provider "azurerm" {
  features {

  }

}

resource "azurerm_resource_group" "rg" {
  name     = "your-rg"
  location = "your-location"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "your-vnet"
  address_space       = ["0.0.0.0/"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

}

resource "azurerm_subnet" "subnet" {
  name                 = "your-subnet"
  address_prefixes     = ["0.0.0.0/"]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_group" "nsg" {
  name                = "your-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azure_network_interface" "nic" {
  name                = "your-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }


}

resource "azurerm_virtual_machine" "vm" {
  name                  = "your-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  vm_size               = "your-size"
  network_interface_ids = ["azurerm_network_interface.mic.id"]
  storage_os_disk {
    name          = "your-name"
    create_option = "FromImage"
    caching       = "ReadWrite"

  }


}
