resource "azurerm_linux_virtual_machine" "web" {
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.base.name
  location              = azurerm_resource_group.base.location
  network_interface_ids = [azurerm_network_interface.web.id]

  size           = var.vm_size
  admin_username = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }
  source_image_reference {
    publisher = var.vm_image.publisher
    offer     = var.vm_image.offer
    sku       = var.vm_image.sku
    version   = var.vm_image.version
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
