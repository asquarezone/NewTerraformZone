variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = optional(string, "Inbound")
    protocol                   = optional(string, "Tcp")
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = optional(string, "*")
    access                     = optional(string, "Deny")
  }))

}