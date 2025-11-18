output "vm_public_ip" {
    value = azurerm_public_ip.primary_web.ip_address
}