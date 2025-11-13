# vpc

resource "aws_vpc" "base" {
  cidr_block           = var.vpc_info.cidr
  enable_dns_hostnames = var.vpc_info.enable_dns_hostnames
  tags                 = var.vpc_info.tags
  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.base.id
  availability_zone = var.public_subnets[count.index].az
  cidr_block        = var.public_subnets[count.index].cidr
  tags              = var.public_subnets[count.index].tags

  lifecycle {
    create_before_destroy = true
  }

  # explicit dependency
  depends_on = [aws_vpc.base]

}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.base.id
  availability_zone = var.private_subnets[count.index].az
  cidr_block        = var.private_subnets[count.index].cidr
  tags              = var.private_subnets[count.index].tags

  lifecycle {
    create_before_destroy = true
  }

  # explicit dependency
  depends_on = [aws_vpc.base]

}


resource "aws_internet_gateway" "base" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_vpc.base]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "private"
    Env  = "Dev"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_subnet.private]

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "public"
    Env  = "Dev"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.base, aws_subnet.public]

}


resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.base.id
  destination_cidr_block = local.anywhere

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.base, aws_route_table.public]


}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}


resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[count.index].id
}

# parent
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.base.id
  tags   = var.web_security_group_info.tags

}

# child
resource "aws_vpc_security_group_ingress_rule" "web_rules" {
  count             = length(var.web_security_group_info.ingress_rules)
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = var.web_security_group_info.ingress_rules[count.index].cidr_ipv4
  from_port         = var.web_security_group_info.ingress_rules[count.index].from_port
  ip_protocol       = var.web_security_group_info.ingress_rules[count.index].ip_protocol
  to_port           = var.web_security_group_info.ingress_rules[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "web_rules" {
  count             = length(var.web_security_group_info.egress_rules)
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = var.web_security_group_info.egress_rules[count.index].cidr_ipv4
  ip_protocol       = var.web_security_group_info.egress_rules[count.index].ip_protocol
}

