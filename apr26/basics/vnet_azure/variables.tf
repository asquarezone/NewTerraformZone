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

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "vm_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
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
