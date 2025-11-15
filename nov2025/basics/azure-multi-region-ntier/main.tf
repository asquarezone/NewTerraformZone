# resource group

resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.primary_location
}

# virtual network
module "primary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "primary"
    location = "centralindia"
    cidr     = "10.101.0.0/16"
  }
  public_subnets = [{
    cidr = "10.101.0.0/24"
    name = "web"
    }, {
    cidr = "10.101.1.0/24"
    name = "app"
    }, {
    cidr = "10.101.2.0/24"
    name = "db"
  }]

}


module "secondary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "secondary"
    location = "southindia"
    cidr     = "10.102.0.0/16"
  }
  public_subnets = [{
    cidr = "10.102.0.0/24"
    name = "web"
    }, {
    cidr = "10.102.1.0/24"
    name = "app"
    }, {
    cidr = "10.102.2.0/24"
    name = "db"
  }]

}