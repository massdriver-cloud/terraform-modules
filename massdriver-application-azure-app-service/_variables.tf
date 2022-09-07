variable "acr" {
  type = object({
    registry_name           = string
    registry_resource_group = string
    repo_name               = string
    tag                     = string
  })
}

variable "dns" {
  type = object({
    enable_dns          = bool
    txt_record          = string
    cname_record        = string
    zone_name           = string
    zone_resource_group = string
  })
}

variable "application" {
  type = object({
    location             = string
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
    notification_email   = string
  })
}

variable "md_metadata" {
  type = object({
    name_prefix = string
  })
}

variable "name" {
  type = string
}
