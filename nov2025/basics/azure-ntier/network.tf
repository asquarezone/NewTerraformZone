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