variable "image" {
  type = object({
    repository = string
    tag        = string
  })
}

variable "dns" {
  type = any
}

variable "application" {
  type = object({
    location             = string
    cidr                 = string
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
    zone_balancing       = bool
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

variable "command" {
  type    = string
  default = null
}

variable "virtual_network_id" {
  type = string
}
