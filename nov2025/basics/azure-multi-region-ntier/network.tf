resource "azurerm_virtual_network" "primary" {

  location            = var.base_infra_info.primary_region
  name                = var.primary_network_info.name
  address_space       = [var.primary_network_info.cidr]
  resource_group_name = azurerm_resource_group.base.name

  depends_on = [azurerm_resource_group.base]

}

resource "azurerm_subnet" "subnets" {

  count                = length(var.primary_network_info.subnets)
  name                 = var.primary_network_info.subnets[count.index].name
  address_prefixes     = [var.primary_network_info.subnets[count.index].cidr]
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.primary

  depends_on = [azurerm_virtual_network.primary]

}