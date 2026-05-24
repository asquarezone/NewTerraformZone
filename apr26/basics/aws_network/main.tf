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

module "security_group" {
    source = "git::https://github.com/asquarezone/TerraformModules.git//aws/securitygroupv2"
    vpc_id = "vpc-0848da751eeb80da2"
    web_security_group = {
        name = "webtf"

  ingress_rules = [{
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"

    }, {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"

    }, {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr_ipv4   = "0.0.0.0/0"

  }]
    }
  
}