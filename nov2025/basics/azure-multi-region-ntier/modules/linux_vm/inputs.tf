variable "subnet_id" {
    type = string
}

variable "username" {
    type = string
}

variable "ssh_key_location" {
    type = string
  
}

variable "vm_size" {
    type = string
    default = "Standard_B1s"
  
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "public_ip_name" {
    type = string
    default = "web"
  
}

variable "nic_name" {
    type = string
    default = "webnic"
  
}

variable "vm_name" {
    type = string
    default = "web"

  
}

variable "nsg_id" {
    type = string
  
}