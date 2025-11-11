region = "ap-south-1"
vpc_info = {
  cidr = "10.101.0.0/16"
  tags = {
    Name = "ntier"
    Env  = "dev"
  }
  enable_dns_hostnames = true
}

public_subnets = [{
  az   = "ap-south-1a"
  cidr = "10.101.0.0/24"
  tags = {
    Name = "web-1"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.101.3.0/24"
  tags = {
    Name = "web-2"
    Env  = "dev"
  }
}]

private_subnets = [{
  az   = "ap-south-1a"
  cidr = "10.101.1.0/24"
  tags = {
    Name = "app-1"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1a"
  cidr = "10.101.2.0/24"
  tags = {
    Name = "db-1"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.101.4.0/24"
  tags = {
    Name = "app-2"
    Env  = "dev"
  }
  }, {
  az   = "ap-south-1b"
  cidr = "10.101.5.0/24"
  tags = {
    Name = "db-2"
    Env  = "dev"
  }
}]

web_security_group_info = {
  name = "web"
  tags = {
    Name = "web"
    Env  = "dev"
  }
  ingress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 80
    ip_protocol = "tcp"
    to_port     = 80
    }, {
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 443
    ip_protocol = "tcp"
    to_port     = 443
    }, {
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    ip_protocol = "tcp"
    to_port     = 22
    }
  ]
  egress_rules = [{
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
  }]
}
