variable "vpc_cidr" {
    type = string
    description = "vpc cidr"
    default = "192.168.0.0/16"
}

# -------------------
# Web Subnet Variables
# -------------------

variable "web_subnet_cidr" {
    type = string
    description = "web subnet cidr"
    default = "192.168.0.0/24"
}

variable "web_subnet_az" {
    type = string
    description = "web subnet az"
    default = "ap-south-1a"
}

# -------------------
# App Subnet Variables
# -------------------
variable "app_subnet_cidr" {
  type        = string
  description = "App subnet CIDR block"
  default     = "192.168.1.0/24"
}

variable "app_subnet_az" {
  type        = string
  description = "App subnet Availability Zone"
  default     = "ap-south-1b"
}

# -------------------
# DB Subnet Variables
# -------------------
variable "db_subnet_cidr" {
  type        = string
  description = "DB subnet CIDR block"
  default     = "192.168.2.0/24"
}

variable "db_subnet_az" {
  type        = string
  description = "DB subnet Availability Zone"
  default     = "ap-south-1c"
}
