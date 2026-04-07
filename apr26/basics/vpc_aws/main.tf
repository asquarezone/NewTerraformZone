resource "aws_vpc" "ntier" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "from-tf"
  }

}
