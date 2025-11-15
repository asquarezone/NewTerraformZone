# required argument
variable "resource_group_name" {
  type        = string
  description = "Resource group in which the network will be created"

}


# required argument
variable "network_info" {
  type = object({
    name     = string
    cidr     = optional(string, "10.10.0.0/16")
    location = optional(string, "centralus")


  })
  description = "The network information"
  default = {
    name = "ntier"
  }

}

# required argument
variable "public_subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
  description = "subnet information"

}
