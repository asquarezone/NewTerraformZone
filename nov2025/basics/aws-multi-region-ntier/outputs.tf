output "primary_web_url" {
  value = format("http://%s",module.primary_web.ip_address)

}

output "secondary_web_url" {
  value = format("http://%s",module.secondary_web.ip_address)

}