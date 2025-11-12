resource "azurerm_virtual_network" "base" {
  name                = var.virtual_network_info.name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  address_space       = [var.virtual_network_info.address_space]

  depends_on = [azurerm_resource_group.base]

}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets_info)
  name                 = var.subnets_info[count.index].name
  address_prefixes     = [var.subnets_info[count.index].address_prefix]
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.base.name

}

## security group with no child resources
resource "azurerm_network_security_group" "web" {
  name                = "web"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  security_rule {
    name                       = "openssh"
    description                = "ssh"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    direction                  = "Inbound"
    priority                   = 300
  }

  security_rule {
    name                       = "openhttp"
    description                = "ssh"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    direction                  = "Inbound"
    priority                   = 310
  }

}

## security group with child resources
resource "azurerm_network_security_group" "app" {
  name                = "app"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location

}


resource "azurerm_network_security_rule" "app_ssh" {
  name                        = "ssh"
  resource_group_name         = azurerm_resource_group.base.name
  network_security_group_name = azurerm_network_security_group.app.name
  description                 = "open ssh"
  protocol                    = "Tcp"
  priority                    = 300
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  access                      = "Allow"
  direction                   = "Inbound"

}

resource "azurerm_network_security_rule" "app_http" {
  name                        = "http"
  resource_group_name         = azurerm_resource_group.base.name
  network_security_group_name = azurerm_network_security_group.app.name
  description                 = "open http"
  protocol                    = "Tcp"
  priority                    = 310
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  access                      = "Allow"
  direction                   = "Inbound"

}