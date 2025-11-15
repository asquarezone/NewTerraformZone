resource "azurerm_resource_group" "base" {
    name = "moduledemo"
    location = "centralindia"
  
}

module "my_vnet" {
  source  = "Azure/vnet/azurerm"
  version = "5.0.1"
  resource_group_name = azurerm_resource_group.base.name
  vnet_location = azurerm_resource_group.base.location
  address_space = ["192.168.0.0/16"]
  subnet_prefixes = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
  subnet_names = ["web", "app", "db"]

}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.0"
  cidr = "192.168.0.0/16"
  create_igw = true
  private_subnets = ["192.168.0.0/24", "192.168.1.0/24"]
  public_subnets = ["192.168.2.0/24", "192.168.3.0/24"]
  azs = ["us-west-2a", "us-west-2b"]
}