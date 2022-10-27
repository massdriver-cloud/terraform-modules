variable "docker" {
  type = object({
    registry = string
    image    = string
    tag      = string
  })
}


variable "application" {
  type = object({
    sku_name             = string
    minimum_worker_count = number
    maximum_worker_count = number
    cidr                 = string
    zone_balancing       = bool
  })
}

variable "dns" {
  type = any
}

variable "name" {
  type = string
}

variable "tags" {
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