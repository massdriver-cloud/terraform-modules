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

variable "dns" {
  type        = any
  description = "DNS configuration."
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
