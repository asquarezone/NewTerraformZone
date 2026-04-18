# deal with resource group

resource "azurerm_resource_group" "base" {
  name     = var.resource_group.name
  location = var.resource_group.location
}