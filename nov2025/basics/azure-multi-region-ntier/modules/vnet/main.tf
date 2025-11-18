resource "azurerm_virtual_network" "base" {

  location            = var.network_info.location
  name                = var.network_info.name
  address_space       = [var.network_info.cidr]
  resource_group_name = var.resource_group_name

}

resource "azurerm_subnet" "subnets" {

  count                = length(var.public_subnets)
  name                 = var.public_subnets[count.index].name
  address_prefixes     = [var.public_subnets[count.index].cidr]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.base.name

  depends_on = [azurerm_virtual_network.base]

}


