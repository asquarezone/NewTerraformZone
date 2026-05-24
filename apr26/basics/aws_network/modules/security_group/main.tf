
resource "aws_security_group" "web" {
  name   = var.web_security_group.name
  vpc_id = var.vpc_id
  tags = {
    Name = var.web_security_group.name
  }

}

resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_security_group.ingress_rules)
  cidr_ipv4         = var.web_security_group.ingress_rules[count.index].cidr_ipv4
  from_port         = var.web_security_group.ingress_rules[count.index].from_port
  ip_protocol       = var.web_security_group.ingress_rules[count.index].ip_protocol
  to_port           = var.web_security_group.ingress_rules[count.index].to_port
  security_group_id = aws_security_group.web.id

}
locals {
  anywhere = "0.0.0.0/0"
}

# all traffic egress rule
resource "aws_vpc_security_group_egress_rule" "web" {
  cidr_ipv4         = local.anywhere
  from_port         = -1
  ip_protocol       = "-1"
  security_group_id = aws_security_group.web.id
  to_port           = -1
}
