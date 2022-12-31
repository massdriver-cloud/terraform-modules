variable "cloud_dns_managed_zones" {
  type    = any
  default = []
}

variable "gcp_config" {
  type = object({
    project_id = string
  })
}
