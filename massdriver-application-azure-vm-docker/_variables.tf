variable "azure_service_principal" {
  type = any
}

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

# variable "vm" {
#   type = object({
#     vm_size        = string
#     disk_size      = number
#     disk_type      = string
#     admin_username = string
#   })
# }

# variable "scaleset" {
#   type = object({
#     enable_scaleset = bool
#     instances       = number
#     max_instances   = number
#   })
# }

# variable "autoscaling" {
#   type = any
# }

# variable "monitoring" {
#   type = object({
#     mode = string
#   })
# }

# variable "dns" {
#   type = any
# }

# variable "name" {
#   type = string
# }

# variable "tags" {
#   type = any
# }

# variable "virtual_network_id" {
#   type = string
# }





# variable "contact_email" {
#   type = string
# }
