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