output "security_group_id" {
    value = aws_security_group.web.id
}

output "network_id" {
    value = var.vpc_id
}

output "other_info" {
    value = aws_security_group.web
  
}