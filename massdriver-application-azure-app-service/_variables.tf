variable "image" {
  type = object({
    repository = string
    tag        = string
  })
}

variable "dns" {
  type = any
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
    minimum_worker_count = optional(number)
    maximum_worker_count = optional(number)
    zone_balancing       = optional(bool)
  })
}

variable "contact_email" {
  type = string
}

variable "command" {
  type    = string
  default = null
}

variable "location" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "network" {
  type = any
}

variable "monitoring" {
  type = object({
    mode = string
  })
}

variable "md_metadata" {
  type = any
}
