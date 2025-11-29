resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.region
  tags = {
    Environment = terraform.workspace
  }
}

resource "azurerm_kubernetes_cluster" "base" {
  name                = var.cluster_name
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = terraform.workspace
  }

}

resource "null_resource" "cli" {
  triggers = {
    build_id = var.build_id
  }
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.base.name} --name ${azurerm_kubernetes_cluster.base.name} --overwrite-existing"

  }

  depends_on = [azurerm_kubernetes_cluster.base]

}
