resource "aws_vpc" "ntier" {
  cidr_block = var.network_cidr
  tags = {
    Name = var.network_name_tag
  }
}

resource "aws_subnet" "subnets" {
  # dynamic value and it becomes a dependency
  # this is referred as implicit dependency
  count             = length(var.subnets)
  vpc_id            = aws_vpc.ntier.id
  availability_zone = var.subnets[count.index].availability_zone
  cidr_block        = var.subnets[count.index].cidr_block

  tags = {
    Name = var.subnets[count.index].name
  }
  # explicit dependency
  depends_on = [
    aws_vpc.ntier
  ]
}

# resource "aws_subnet" "two" {
#   vpc_id            = aws_vpc.ntier.id # dynamic value
#   availability_zone = var.subnet_two.availability_zone
#   cidr_block        = var.subnet_two.cidr_block

#   tags = {
#     Name = var.subnet_two.name
#   }
#   depends_on = [
#     aws_vpc.ntier
#   ]
# }
