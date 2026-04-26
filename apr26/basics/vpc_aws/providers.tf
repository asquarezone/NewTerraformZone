terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.39"
    }
  }
  backend "s3" {
    bucket = "terraform-qt-tfstate"
    region = "ap-south-1"
    key = "terraform/ntier/state"
    use_lockfile = true
    
  }
}

provider "aws" {
  region = var.region

}