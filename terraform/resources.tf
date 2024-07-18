resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
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

resource "azurerm_public_ip" "apip" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Dynamic"
  sku                 = var.sku
}

resource "azurerm_network_interface" "ani" {
  name                = var.network_interface_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  ip_configuration {
    name                          = "ccbcp2aniipconfig"
    subnet_id                     = azurerm_subnet.asub.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.apip.id
  }
}

resource "azurerm_network_security_group" "ansg" {
  name                = var.network_security_group_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  security_rule {
    name                       = "ccbcp2ansgsr"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "anisga" {
  network_interface_id      = azurerm_network_interface.ani.id
  network_security_group_id = azurerm_network_security_group.ansg.id
}

resource "azurerm_lb" "alb" {
  name                = var.load_balancer_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

resource "azurerm_storage_account" "asa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_linux_virtual_machine" "avm" {
  name                  = var.virtual_machine_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.virtual_machine_size
  availability_set_id   = azurerm_availability_set.aas.id
  network_interface_ids = [azurerm_network_interface.ani.id]
  admin_username        = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.asa.primary_blob_endpoint
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.kubernetes_cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns_prefix          = var.kubernetes_cluster_name

  default_node_pool {
    name       = var.kubernetes_cluster_name
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "basic"
    network_plugin    = "kubenet"
  }
}
