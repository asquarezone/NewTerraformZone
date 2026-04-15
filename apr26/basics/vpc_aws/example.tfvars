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
