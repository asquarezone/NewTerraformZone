output "network_name" {
  value = azurerm_virtual_network.ntier.name
}

output "subnet_names" {
  value = azurerm_subnet.subnets[*].name
}

output "web_public_ip" {
  value = azurerm_public_ip.web.ip_address
}