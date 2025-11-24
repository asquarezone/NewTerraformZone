# resource group
resource "azurerm_resource_group" "base" {
  location = "centralindia"
  name     = "website"
}


resource "azurerm_public_ip" "web_1" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.base.location
  name                = "web-1-ip"
  resource_group_name = azurerm_resource_group.base.name
  sku_tier            = "Regional"
  zones               = ["1", ]
}


resource "azurerm_virtual_network" "base" {
  address_space = [
    "172.16.0.0/16",
  ]
  location = azurerm_resource_group.base.location

  name                = "vnet-centralindia"
  resource_group_name = azurerm_resource_group.base.name
  subnet {
    default_outbound_access_enabled = false
    address_prefixes = [
      "172.16.0.0/24",
    ]
    name = "snet-centralindia-1"
  }

}


resource "azurerm_network_security_group" "web" {
  location            = azurerm_resource_group.base.location
  name                = "web-1-nsg"
  resource_group_name = azurerm_resource_group.base.name
  security_rule = [
    {
      access                                     = "Allow"
      description                                = null
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "22"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "SSH"
      priority                                   = 300
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
    {
      access                                     = "Allow"
      description                                = null
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      destination_application_security_group_ids = []
      destination_port_range                     = "80"
      destination_port_ranges                    = []
      direction                                  = "Inbound"
      name                                       = "HTTP"
      priority                                   = 320
      protocol                                   = "Tcp"
      source_address_prefix                      = "*"
      source_address_prefixes                    = []
      source_application_security_group_ids      = []
      source_port_range                          = "*"
      source_port_ranges                         = []
    },
  ]
}
