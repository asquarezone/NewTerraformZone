region = "ap-south-1"
vpc_info = {
  cidr = "10.10.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "dev"
  }
  enable_dns_hostnames = true
}

web_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.0.0/24"
  tags = {
    Name = "web"
    Env  = "dev"
  }
}

app_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.1.0/24"
  tags = {
    Name = "app"
    Env  = "dev"
  }
}

db_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.2.0/24"
  tags = {
    Name = "db"
    Env  = "dev"
  }
}