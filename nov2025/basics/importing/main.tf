# vpc
# aws_vpc.base:
resource "aws_vpc" "base" {
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  region                               = "us-west-2"
  tags = {
    "Name" = "ntier-vpc"
  }
  tags_all = {
    "Name" = "ntier-vpc"
  }
}

# internet gateway
# aws_internet_gateway.base:
resource "aws_internet_gateway" "base" {
  region = "us-west-2"
  tags = {
    "Name" = "ntier-igw"
  }
  tags_all = {
    "Name" = "ntier-igw"
  }
  vpc_id     = aws_vpc.base.id
  depends_on = [aws_vpc.base]
}


# subnets
resource "aws_subnet" "public_1" {
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.0.0/20"
  tags = {
    "Name" = "ntier-subnet-public1-us-west-2a"
  }
  tags_all = {
    "Name" = "ntier-subnet-public1-us-west-2a"
  }
  vpc_id = aws_vpc.base.id
}

resource "aws_subnet" "public_2" {
  availability_zone = "us-west-2b"
  cidr_block        = "10.0.16.0/20"
  tags = {
    "Name" = "ntier-subnet-public2-us-west-2b"
  }
  tags_all = {
    "Name" = "ntier-subnet-public2-us-west-2b"
  }
  vpc_id = aws_vpc.base.id
}

# security group
# aws_security_group.web:
resource "aws_security_group" "web" {
    description = "Allow "
    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]
    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = null
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name        = "openhttpnssh"
    tags        = {
        "Name" = "openhttpnssh"
    }
    tags_all    = {
        "Name" = "openhttpnssh"
    }
    vpc_id      = aws_vpc.base.id
}
