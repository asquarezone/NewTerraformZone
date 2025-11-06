# vpc

resource "aws_vpc" "base" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }

}


resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.base.id # implicit dependency
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.0.0/24"
  tags = {
    Name = "web"
    Env  = "Dev"
  }
  # explicit dependency
  depends_on = [aws_vpc.base]

}


resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.base.id # implicit dependency
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.1.0/24"
  tags = {
    Name = "app"
    Env  = "Dev"
  }
  # explicit dependency
  depends_on = [aws_vpc.base]

}


resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.base.id # implicit dependency
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.2.0/24"
  tags = {
    Name = "db"
    Env  = "Dev"
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
  depends_on = [aws_vpc.base]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "private"
    Env  = "Dev"
  }

  depends_on = [aws_subnet.db, aws_subnet.app]

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.base.id

  tags = {
    Name = "public"
    Env  = "Dev"
  }

  depends_on = [aws_internet_gateway.base, aws_subnet.web]

}


resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.base.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_internet_gateway.base, aws_route_table.public]

}


resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.web.id
}


resource "aws_route_table_association" "private_app" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.app.id
}

resource "aws_route_table_association" "private_db" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.db.id
}
