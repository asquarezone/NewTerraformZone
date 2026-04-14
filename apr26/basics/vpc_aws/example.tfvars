network_cidr     = "10.10.0.0/16"
network_name_tag = "my-first-vpc"
region           = "ap-south-1"
# subnet_one = {
#   availability_zone = "ap-south-1a"
#   cidr_block        = "10.10.0.0/24"
#   name              = "one"
# }
# subnet_two = {
#   availability_zone = "ap-south-1b"
#   cidr_block        = "10.10.1.0/24"
#   name              = "two"
# }

subnets = [{
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
