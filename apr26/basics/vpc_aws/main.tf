resource "aws_vpc" "ntier" {
  cidr_block = var.network_cidr
  tags = {
    Name = var.network_name_tag
  }
}

resource "aws_subnet" "one" {
  # dynamic value and it becomes a dependency
  # this is referred as implicit dependency
  vpc_id            = aws_vpc.ntier.id 
  availability_zone = "ap-south-1a"
  cidr_block        = "10.10.0.0/24"

  tags = {
    Name = "one"
  }
  # explicit dependency
  depends_on = [ 
    aws_vpc.ntier 
  ]
}

resource "aws_subnet" "two" {
  vpc_id            = aws_vpc.ntier.id # dynamic value
  availability_zone = "ap-south-1b"
  cidr_block        = "10.10.1.0/24"

  tags = {
    Name = "two"
  }
  depends_on = [ 
    aws_vpc.ntier
  ]
}
