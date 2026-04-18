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