variable "image" {
  type = object({
    repository = string
    tag        = string
  })
}

variable "dns" {
  type = object({
    enable_dns          = bool
    alias               = string
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
  })
}

variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "contact_email" {
  type = string
}
