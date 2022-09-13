variable "repo" {
  type = object({
    docker_image     = string
    docker_image_tag = string
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

variable "name" {
  type = string
}

variable "tags" {
  type = object({
    md-project  = string
    md-target   = string
    md-manifest = string
    md-package  = string
  })
}
