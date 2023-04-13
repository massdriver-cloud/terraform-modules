variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "md_metadata" {
  type = any
}

variable "image" {
  type = object({
    registry = string
    name     = string
    tag      = string
  })
}

variable "health_check" {
  type = object({
    port = optional(number, 80)
    path = optional(string, "/")
  })
}

variable "application" {
  type = object({
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
    zone_balancing       = bool
    logs = object({
      retention_period_days = number
      disk_quota_mb         = number
    })
  })
}

variable "monitoring" {
  type = object({
    mode = string
  })
}

variable "dns" {
  type = any
}

variable "virtual_network_id" {
  type = string
}

variable "contact_email" {
  type = string
}

variable "location" {
  type = string
}

variable "network" {
  type = any
}
