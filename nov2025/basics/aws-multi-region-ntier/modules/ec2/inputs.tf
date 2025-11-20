variable "ami_id" {
  type = string

}

variable "instance_type" {
  type    = string
  default = "t3.micro"

}

variable "subnet_id" {
  type = string

}

variable "security_group_id" {
  type = string

}


variable "key_name" {
  type = string

}
