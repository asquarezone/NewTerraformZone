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

resource "aws_vpc" "ntier" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "from-tf"
  }

}
