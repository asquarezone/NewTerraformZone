variable "region" {
    type = string
    default = "eastus"
}

variable "resource_group_name" {
    type = string
    default = "rg-terraform"
}

variable "vm_size" {
    type = string
    default = "Standard_A2_v2"
}

variable "node_count" {
    type = number
    default = 1
}

variable "cluster_name" {
    type = string
    default = "myaks-cluster"
}

variable "build_id" {
    type = string
    default = "1"
}

variable "dns_prefix" {
    type = string
    default = "myaks"
}
