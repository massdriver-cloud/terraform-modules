variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "location" {
  type = string
}

variable "resource_requests" {
  type = object({
    cpu    = number
    memory = string
  })
}

variable "container" {
  type = object({
    repository = string
    tag        = string
  })
}

variable "health_check" {
  type = object({
    port = optional(number, 80)
    path = optional(string, "/")
  })
}

variable "dns" {
  type = object({
    enable_dns = bool
    zone_id    = optional(string, "")
    subdomain  = optional(string, "")
  })
  default = {
    enable_dns = false
  }
}

variable "virtual_network_id" {
  type = string
}
