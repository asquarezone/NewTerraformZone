variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "region where the network will be created"
}

variable "network_cidr" {
  type        = string
  description = "network cidr range"
}

variable "network_name_tag" {
  type        = string
  default     = "ntier"
  description = "name tag for vpc"
}

variable "subnets" {
  type = list(object({
    name              = string
    cidr_block        = string
    availability_zone = string
  }))
  default = [{
    availability_zone = "ap-south-1a"
    cidr_block        = "10.0.0.0/24"
    name              = "one"
    },
    {
      availability_zone = "ap-south-1b"
      cidr_block        = "10.0.1.0/24"
      name              = "two"
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
