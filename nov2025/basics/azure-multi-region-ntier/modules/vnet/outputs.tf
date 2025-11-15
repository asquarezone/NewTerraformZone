output "vnet_id" {
  value = azurerm_virtual_network.base.id

}

output "vnet_name" {
  value = azurerm_virtual_network.base.name
}

output "subnet_ids" {
  value = azurerm_subnet.subnets[*].id

}

output "subnet_names" {
  value = azurerm_subnet.subnets[*].name

}
