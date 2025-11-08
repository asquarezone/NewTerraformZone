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

# -------------------
# Web Subnet Variables
# -------------------

variable "web_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.0.0/24"
    tags = {
      Name = "web"
      Env  = "Dev"
    }
  }
  description = "web subnet information"

}

# -------------------
# App Subnet Variables
# -------------------

variable "app_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.1.0/24"
    tags = {
      Name = "app"
      Env  = "Dev"
    }
  }
  description = "app subnet information"

}



# -------------------
# DB Subnet Variables
# -------------------

variable "db_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.2.0/24"
    tags = {
      Name = "db"
      Env  = "Dev"
    }
  }
  description = "db subnet information"

}

