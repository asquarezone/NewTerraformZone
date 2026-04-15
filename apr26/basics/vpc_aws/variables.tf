variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "region where the network will be created"
}

variable "network_cidr" {
  type        = string
  description = "network cidr range"
  default     = "10.0.0.0/16"
}

variable "network_name_tag" {
  type        = string
  default     = "ntier"
  description = "name tag for vpc"
}

variable "private_subnets" {
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = [{
    availability_zone = "ap-south-1a"
    cidr_block        = "10.0.0.0/24"
    name              = "db-1"
    },
    {
      availability_zone = "ap-south-1b"
      cidr_block        = "10.0.1.0/24"
      name              = "db-2"
  }]

}

variable "public_subnets" {
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = [{
    availability_zone = "ap-south-1a"
    cidr_block        = "10.0.2.0/24"
    name              = "web-1"
    },
    {
      availability_zone = "ap-south-1b"
      cidr_block        = "10.0.3.0/24"
      name              = "web-2"
  }]

}

# variable "subnet_one" {
#   type = object({
#     name              = string
#     cidr_block        = string
#     availability_zone = string
#   })
#   default = {
#     availability_zone = "ap-south-1a"
#     cidr_block        = "10.0.0.0/24"
#     name              = "one"
#   }
# }

# variable "subnet_two" {
#   type = object({
#     name              = string
#     cidr_block        = string
#     availability_zone = string
#   })
#   default = {
#     availability_zone = "ap-south-1b"
#     cidr_block        = "10.0.1.0/24"
#     name              = "two"
#   }
# }
