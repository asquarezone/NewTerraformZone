# resource group

resource "azurerm_resource_group" "base" {
  name     = var.base_infra_info.resource_group_name
  location = var.base_infra_info.primary_region
}