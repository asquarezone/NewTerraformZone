resource "azurerm_virtual_network" "ntier" {
  name                = var.network_info.name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  depends_on          = [azurerm_resource_group.base]
  address_space       = [var.network_info.address_space]
}


resource "azurerm_subnet" "subnets" {
  count                           = length(var.subnets)
  name                            = var.subnets[count.index].name
  resource_group_name             = azurerm_resource_group.base.name
  virtual_network_name            = azurerm_virtual_network.ntier.name
  address_prefixes                = [var.subnets[count.index].address_space]
  default_outbound_access_enabled = var.subnets[count.index].is_public_subnet

}

# public ip
resource "azurerm_public_ip" "web" {
  name                = "web-ip"
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  allocation_method   = "Static"
}


# network interface
resource "azurerm_network_interface" "web" {
  name                = var.nic_name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  ip_configuration {
    name                          = var.nic_name
    subnet_id                     = azurerm_subnet.subnets[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }

}

# network security group
resource "azurerm_network_security_group" "web" {
  name                = var.nsg_name
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location

  security_rule {
    name                       = var.http_rule.name
    priority                   = var.http_rule.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.http_rule.destination_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = var.ssh_rule.name
    priority                   = var.ssh_rule.priority
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.ssh_rule.destination_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_interface_security_group_association" "web" {
  network_interface_id      = azurerm_network_interface.web.id
  network_security_group_id = azurerm_network_security_group.web.id

}