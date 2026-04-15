resource "aws_vpc" "ntier" {
  cidr_block = var.network_cidr
  tags = {
    Name = format("%s-%s-%s", local.organization, local.project, var.network_name_tag)
  }
}

# route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = format("%s-%s-private", local.organization, local.project)
  }

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = format("%s-%s-public", local.organization, local.project)
  }

}

# internet gateway

resource "aws_internet_gateway" "ntier" {
  vpc_id = aws_vpc.ntier.id
  tags = {
    Name = format("%s-%s-igw", local.organization, local.project)
  }

}

# connecting public route table to internet gateway
resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = local.anywhere # anywhere
  gateway_id             = aws_internet_gateway.ntier.id

}

resource "aws_subnet" "public_subnets" {
  # dynamic value and it becomes a dependency
  # this is referred as implicit dependency
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.ntier.id
  availability_zone = var.public_subnets[count.index].availability_zone
  cidr_block        = var.public_subnets[count.index].cidr_block

  tags = {
    Name = format("%s-%s-%s", local.organization, local.project, var.public_subnets[count.index].name)
  }
  # explicit dependency
  depends_on = [
    aws_vpc.ntier
  ]
}

resource "aws_subnet" "private_subnets" {
  # dynamic value and it becomes a dependency
  # this is referred as implicit dependency
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.ntier.id
  availability_zone = var.private_subnets[count.index].availability_zone
  cidr_block        = var.private_subnets[count.index].cidr_block

  tags = {
    Name = format("%s-%s-%s", local.organization, local.project, var.private_subnets[count.index].name)
  }
  # explicit dependency
  depends_on = [
    aws_vpc.ntier
  ]
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}
