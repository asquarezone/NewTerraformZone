variable "key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"

}

variable "build_id" {
  type = string
  default = "1"
  
}

variable "primary_region" {
  type    = string
  default = "us-west-2"
}

variable "secondary_region" {
  type    = string
  default = "us-east-1"
}

variable "primary_vpc_cidr" {
  type    = string
  default = "10.100.0.0/16"
}

variable "secondary_vpc_cidr" {
  type    = string
  default = "10.101.0.0/16"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "security_group_name" {
  type    = string
  default = "my-security-group"
}

variable "ubuntu_ami_name_pattern" {
  type    = string
  default = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
}

variable "canonical_owner_id" {
  type    = string
  default = "099720109477"
}