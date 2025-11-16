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