module "primary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.primary
  }
  vpc_info = {
    cidr                 = "10.100.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name = "primary"
    }
  }
  public_subnets = [{
    az   = "us-west-2a",
    cidr = "10.100.0.0/24",
    tags = {
      Name = "web1"
    }
    }, {
    az   = "us-west-2b",
    cidr = "10.100.1.0/24",
    tags = {
      Name = "web2"
    }
  }]
  private_subnets = [{
    az   = "us-west-2a",
    cidr = "10.100.2.0/24",
    tags = {
      Name = "app1"
    }
    }, {
    az   = "us-west-2b",
    cidr = "10.100.3.0/24",
    tags = {
      Name = "app2"
    }
    }, {
    az   = "us-west-2a",
    cidr = "10.100.4.0/24",
    tags = {
      Name = "db1"
    }
    }, {
    az   = "us-west-2b",
    cidr = "10.100.5.0/24",
    tags = {
      Name = "db2"
    }
  }]

}

module "secondary_vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.secondary
  }
  vpc_info = {
    cidr                 = "10.101.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name = "secondary"
    }
  }
  public_subnets = [{
    az   = "us-east-1a",
    cidr = "10.101.0.0/24",
    tags = {
      Name = "web1"
    }
    }, {
    az   = "us-east-1b",
    cidr = "10.101.1.0/24",
    tags = {
      Name = "web2"
    }
  }]
  private_subnets = [{
    az   = "us-east-1a",
    cidr = "10.101.2.0/24",
    tags = {
      Name = "app1"
    }
    }, {
    az   = "us-east-1b",
    cidr = "10.101.3.0/24",
    tags = {
      Name = "app2"
    }
    }, {
    az   = "us-east-1a",
    cidr = "10.101.4.0/24",
    tags = {
      Name = "db1"
    }
    }, {
    az   = "us-east-1b",
    cidr = "10.101.5.0/24",
    tags = {
      Name = "db2"
    }
  }]

}