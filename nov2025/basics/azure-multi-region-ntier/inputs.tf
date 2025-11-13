variable "base_infra_info" {
  type = object({
    resource_group_name = optional(string, "multiregionntier")
    primary_region      = string
    secondary_region    = string
  })

}

variable "primary_network_info" {
  type = object({
    name = string
    cidr = optional(string, "10.10.0.0/16")
    subnets = list(object({
      name = string
      cidr = string
    }))
  })

}