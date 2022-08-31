variable "acr" {
  type = object({
    registry_name           = string
    registry_resource_group = string
    repo_name               = string
  })
}

variable "dns" {
  type = object({
    enable_dns          = boolean
    txt_record          = string
    cname_record        = string
    zone_name           = string
    zone_resource_group = string
  })
}

variable "application" {
  type = object({
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
    notification_email   = string
  })
}
