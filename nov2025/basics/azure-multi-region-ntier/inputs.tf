variable "base_infra_info" {
  type = object({
    resource_group_name = optional(string, "multiregionntier")
    primary_region      = string
    secondary_region    = string
  })

}