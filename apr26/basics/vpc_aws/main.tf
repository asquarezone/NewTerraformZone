resource "aws_vpc" "ntier" {
  cidr_block = var.network_cidr
  tags = {
    Name = var.network_name_tag
  }
}
