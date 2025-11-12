variable "vpc_info" {
  type = object({
    cidr                 = string
    tags                 = map(string)
    enable_dns_hostnames = bool
  })
  description = "vpc information"
  default = {
    cidr = "192.168.0.0/16"
    tags = {
      Name = "from-tf"
      Env  = "Dev"
    }
    enable_dns_hostnames = true
  }

}


variable "region" {
  type    = string
  default = "ap-south-1"

}

variable "public_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "public subnets"

}


variable "private_subnets" {
  type = list(object({
    cidr = string
    az   = string
    tags = map(string)
  }))
  description = "private subnets"

}

variable "web_security_group_info" {
  type = object({
    name = optional(string, "websg")
    tags = map(string)
    ingress_rules = list(object({
      cidr_ipv4   = optional(string,"0.0.0.0/0") # if user does not pass cidr_ipv4 use "0.0.0.0/0"
      from_port   = number
      ip_protocol = string
      to_port     = number
    }))
    egress_rules = list(object({
      cidr_ipv4   = optional(string,"0.0.0.0/0") # if user does not pass cidr_ipv4 use "0.0.0.0/0"
      ip_protocol = string
    }))
  })
}


