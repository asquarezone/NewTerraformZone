variable "web_security_group" {
  type = object({
    name = string
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      cidr_ipv4   = string
      ip_protocol = string
    }))
  })
}

variable "vpc_id" {
    type = string
}
