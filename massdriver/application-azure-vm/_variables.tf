variable "md_metadata" {
  type = any
}

variable "virtual_network_id" {
  type = any
}

variable "location" {
  type = string
}

variable "health_check" {
  type = object({
    port = optional(number, 80)
    path = optional(string, "/health")
  })
}

variable "auto_scaling" {
  type = object({
    enabled = optional(bool, false)
  })
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


