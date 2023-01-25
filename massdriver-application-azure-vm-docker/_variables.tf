variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "virtual_network_id" {
  type = any
}

variable "location" {
  type = string
}

variable "container" {
  type = object({
    repository = string
    tag        = optional(string, "latest")
  })
}

variable "port" {
  type = number
}

variable "health_check" {
  type = object({
    port = optional(number, 80)
    path = optional(string, "/")
  })
  default = {
    path = "/"
  }
}

variable "auto_scaling_enabled" {
  type    = bool
  default = false
}

variable "endpoint" {
  type = object({
    enabled   = bool
    zone_id   = optional(string, null)
    subdomain = optional(string, null)
  })
  default = {
    enabled = false
  }
}


# variable "autoscaling" {
#   type = any
# }

# variable "monitoring" {
#   type = object({
#     mode = string
#   })
# }
