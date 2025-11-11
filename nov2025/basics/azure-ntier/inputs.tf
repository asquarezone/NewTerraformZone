variable "resource_group_info" {
  type = object({
    name     = string
    location = string
  })

}

variable "virtual_network_info" {
  type = object({
    name          = string
    address_space = string
  })

}

variable "subnets_info" {
  type = list(object({
    name           = string
    address_prefix = string
  }))

}