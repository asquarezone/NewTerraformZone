variable "ami_id" {
  type    = string
  default = "ami-06c28eeae75712f2d"

}

variable "instance_type" {
  type    = string
  default = "t3.micro"

}

variable "subnet_id" {
  type    = string
  default = "subnet-0a07619d4355c325d"

}

variable "security_group_id" {
  type    = string
  default = "sg-03682bdc0b4357d31"

}

