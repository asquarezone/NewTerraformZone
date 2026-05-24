resource "azurerm_resource_group" "base" {
    name = "aks-cluster"
    location = "eastus"
}

resource "azurerm_kubernetes_cluster" "base" {
    name = "myakscluster"
    location = azurerm_resource_group.base.location
    resource_group_name = azurerm_resource_group.base.name
    dns_prefix = "myakscluster"

    default_node_pool {
      name = "system"
      node_count = 1
      vm_size = "Standard_B2s"
    }
    identity {
      type = "SystemAssigned"
    }
    tags = {
      environment = "dev"
    }
}

resource "null_resource" "base" {
    triggers = {
        set = var.set_cli_auth
    }

    provisioner "local-exec" {
        command = "az aks get-credentials --resource-group ${azurerm_resource_group.base.name} --name ${azurerm_kubernetes_cluster.base.name} --overwrite-existing"
    }

    depends_on = [ azurerm_kubernetes_cluster.base ]
  
}