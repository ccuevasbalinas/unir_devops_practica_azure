resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = var.sku
}

resource "azurerm_availability_set" "aas" {
  name                = var.availability_set_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

resource "azurerm_virtual_network" "avn" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

resource "azurerm_subnet" "asub" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.avn.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "ani" {
  name                = var.network_interface_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.asub.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "ansg" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_interface_security_group_association" "anisga" {
  network_interface_id      = azurerm_network_interface.ani.id
  network_security_group_id = azurerm_network_security_group.ansg.id
}