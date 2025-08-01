variable "name" {
  type = string
}

variable "tags" {
  type = any
}

variable "location" {
  type = string
}

variable "dns" {
  type = any
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

variable "monitoring" {
  type = object({
    mode = string
  })
}

variable "virtual_network_id" {
  type = any
}

variable "network" {
  type = any
}

# variable "autoscaling" {
#   type = any
# }

variable "acme_registration_email_address" {
  type = string
}

variable "machine_type" {
  type = string
}
