output "web_server_ip" {
  value = aws_instance.web.public_ip
}

output "web_server_ssh" {
  #value = "ssh ${var.web_server_info.username}@${aws_instance.web.public_ip}"
  value = format("ssh %s@%s", var.web_server_info.username, aws_instance.web.public_ip)
}