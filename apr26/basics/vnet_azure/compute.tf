resource "azurerm_linux_virtual_machine" "web" {
  name                  = "web-1"
  resource_group_name   = azurerm_resource_group.base.name
  location              = azurerm_resource_group.base.location
  network_interface_ids = [azurerm_network_interface.web.id]

  size           = "Standard_B1s"
  admin_username = "Dell"
  admin_ssh_key {
    username   = "Dell"
    public_key = file("~/.ssh/id_ed25519.pub")
  }
  # source image reference for ubuntu 24.04
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

}
