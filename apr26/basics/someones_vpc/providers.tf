terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.39"
    }
  }

}

provider "aws" {
  region = "ap-south-1"

}