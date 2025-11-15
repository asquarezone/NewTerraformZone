terraform {
  required_version = ">= 1.11.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.52.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

provider "aws" {
    region = "us-west-2"
  
}
