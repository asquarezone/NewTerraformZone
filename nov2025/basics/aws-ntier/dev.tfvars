region = "ap-south-1"
vpc_info = {
  cidr = "10.10.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "dev"
  }
  enable_dns_hostnames = true
}

public_subnets = [{
  az   = "ap-south-1a"
  cidr = "10.10.0.0/24"
  tags = {
    Name = "web-1"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.10.3.0/24"
  tags = {
    Name = "web-2"
    Env  = "dev"
  }
}]

private_subnets = [{
  az   = "ap-south-1a"
  cidr = "10.10.1.0/24"
  tags = {
    Name = "app-1"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1a"
  cidr = "10.10.2.0/24"
  tags = {
    Name = "db-1"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.10.4.0/24"
  tags = {
    Name = "app-2"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.10.5.0/24"
  tags = {
    Name = "db-2"
    Env  = "dev"
  }
}]
