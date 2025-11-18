# resource group

resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.primary_location
}

# virtual network
module "primary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "primary"
    location = "centralindia"
    cidr     = "10.101.0.0/16"
  }
  public_subnets = [{
    cidr = "10.101.0.0/24"
    name = "web"
    }, {
    cidr = "10.101.1.0/24"
    name = "app"
    }, {
    cidr = "10.101.2.0/24"
    name = "db"
  }]

}


module "secondary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "secondary"
    location = "southindia"
    cidr     = "10.102.0.0/16"
  }
  public_subnets = [{
    cidr = "10.102.0.0/24"
    name = "web"
    }, {
    cidr = "10.102.1.0/24"
    name = "app"
    }, {
    cidr = "10.102.2.0/24"
    name = "db"
  }]

}


module "primary_web_nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.base.name
  location            = var.primary_location
  name                = "web_nsg_primary"
  rules = [{
    name                   = "openhttp"
    priority               = 300
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "*"
    destination_port_range = "80"
    access                 = "Allow"
    }, {
    name                   = "openssh"
    priority               = 310
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "*"
    destination_port_range = "22"
    access                 = "Allow"
  }]
  depends_on = [azurerm_resource_group.base]

}

module "secondary_web_nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.base.name
  location            = "southindia"
  name                = "web_nsg_secondary"
  rules = [{
    name                   = "openhttp"
    priority               = 300
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "80"
    destination_port_range = "80"
    access                 = "Allow"
    }, {
    name                   = "openssh"
    priority               = 310
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "22"
    destination_port_range = "22"
    access                 = "Allow"
  }]
  depends_on = [azurerm_resource_group.base]

}


# public ip 

resource "azurerm_public_ip" "primary_web" {
  resource_group_name = azurerm_resource_group.base.name
  location            = var.primary_location
  allocation_method   = "Static"
  name                = "primary_web"

}

# Network interface

resource "azurerm_network_interface" "primary_web" {
  resource_group_name = azurerm_resource_group.base.name
  location            = var.primary_location
  ip_configuration {
    name                          = "primary"
    subnet_id                     = module.primary_vnet.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.primary_web.id
  }
  name = "primary_web_nic"

}


resource "azurerm_linux_virtual_machine" "primary_web" {
  name                = "web1"
  resource_group_name = azurerm_resource_group.base.name
  location            = var.primary_location
  size                = "Standard_B1s"
  admin_username      = "Dell"
  
  network_interface_ids = [
    azurerm_network_interface.primary_web.id,
  ]

  admin_ssh_key {
    username   = "Dell"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}


resource "azurerm_network_interface_security_group_association" "primary" {
  network_interface_id = azurerm_network_interface.primary_web.id
  network_security_group_id = module.primary_web_nsg.id
  
}

