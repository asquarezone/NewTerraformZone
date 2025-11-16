# i want default vpc id


data "aws_vpc" "default" {
    region = "us-west-2"
    default = true
  
}


data "aws_vpc" "created_by_me" {
    region = "us-west-2"
    cidr_block = "10.100.0.0/16"
  
}