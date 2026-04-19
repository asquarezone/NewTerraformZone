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

variable "nic_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "http_rule" {
  type = object({
    name             = string
    priority         = number
    destination_port = string
  })
}

variable "ssh_rule" {
  type = object({
    name             = string
    priority         = number
    destination_port = string
  })
}
