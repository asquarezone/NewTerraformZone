resource "azurerm_network_security_group" "base" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_network_security_rule" "rules" {
  count                       = length(var.rules)
  name                        = var.rules[count.index].name
  priority                    = var.rules[count.index].priority
  direction                   = var.rules[count.index].direction
  access                      = var.rules[count.index].access
  source_port_range           = var.rules[count.index].source_port_range
  source_address_prefix       = var.rules[count.index].source_address_prefix
  destination_port_range      = var.rules[count.index].destination_port_range
  destination_address_prefix  = var.rules[count.index].destination_address_prefix
  protocol                    = var.rules[count.index].protocol
  network_security_group_name = azurerm_network_security_group.base.name
  resource_group_name         = var.resource_group_name
}