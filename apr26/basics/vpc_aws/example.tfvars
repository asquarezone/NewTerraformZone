network_cidr     = "10.10.0.0/16"
network_name_tag = "ntier-vpc"
region           = "ap-south-1"
private_subnets = [{
  availability_zone = "ap-south-1a"
  cidr_block        = "10.10.0.0/24"
  name              = "app-1"
  },
  {
    availability_zone = "ap-south-1b"
    cidr_block        = "10.10.1.0/24"
    name              = "app-2"
    }, {
    availability_zone = "ap-south-1a"
    cidr_block        = "10.10.2.0/24"
    name              = "db-1"
  },
  {
    availability_zone = "ap-south-1b"
    cidr_block        = "10.10.3.0/24"
    name              = "db-2"
}]

public_subnets = [{
  availability_zone = "ap-south-1a"
  cidr_block        = "10.10.10.0/24"
  name              = "web-1"
  },
  {
    availability_zone = "ap-south-1b"
    cidr_block        = "10.10.11.0/24"
    name              = "web-2"
  }
]

web_security_group = {
  name = "web"

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

key_pair_info = {
  key_pair_name = "private"
}

web_server_info = {
  instance_type = "t3.micro"
  ami_id        = "ami-05d2d839d4f73aafb"
}