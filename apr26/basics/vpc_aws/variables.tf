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