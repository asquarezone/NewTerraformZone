variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "network_info" {
  type = object({
    name          = string
    address_space = string
  })
}

variable "subnets" {
  type = list(object({
    name             = string
    address_space    = string
    is_public_subnet = bool
  }))
}